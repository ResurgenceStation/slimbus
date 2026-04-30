{% extends "base/dashboard.html"%}
{% block pagetitle %}Map Data - Round #{{round.id}}{% endblock %}
{% block dashtitle %}Map - Round #{{round.id}}{% endblock %}
{% block content %}

<div class="leaflet-map" id="map"></div>

{% endblock %}

{% block sidebar %}

<h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted"><span>Z-Level</span></h6>
<ul class="nav flex-column" id="zlevel-btns">
</ul>

<h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted"><span>Database</span></h6>
<ul class="nav flex-column">
  <li class="nav-item">
    <a class="nav-link invisible" href="#" id="deaths">
      <i class="fas fa-user-times"></i> Deaths (<span id="deathCount"></span>)
    </a>
  </li>
  <li class="nav-item">
    <a class="nav-link invisible" href="#" id="bombs">
      <i class="fas fa-bomb"></i> Explosions
    </a>
  </li>
</ul>

<h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted"><span>Logfiles</span></h6>
<ul class="nav flex-column" id="logfiles">
</ul>

{% endblock %}

{% block js %}
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" crossorigin=""/>
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" crossorigin=""></script>
<script>
let roundID = window.location.pathname.split('/')[2];
let activeZ     = 1;   // webmap tile z (index into z_levels)
let activeGameZ = 2;   // game db z (what's stored in tbl_death.z_coord etc.)
let tileLayer = null;
let map = null;

// ── Raw data stores (populated on first fetch, re-used on z-level switch) ──
let deathsData  = null;   // array of death objects
let bombsData   = null;   // array of explosion objects
let logRawData  = {};     // filename → array of log line objects

// ── Overlay layer groups ───────────────────────────────────────────────────
var corpses   = L.layerGroup();
var bombs     = L.layerGroup();
var logLayers = {};       // filename → L.layerGroup

// ── Render helpers — clear and repopulate a layer for the current activeGameZ ──
function renderDeaths() {
  corpses.clearLayers();
  if (!deathsData) return;
  deathsData.forEach(function(d) {
    if (parseInt(d.z) !== activeGameZ) return;
    L.polygon([
      tg2leaf(d.x,   d.y),
      tg2leaf(d.x-1, d.y),
      tg2leaf(d.x-1, d.y-1),
      tg2leaf(d.x,   d.y-1)
    ], {color: 'red'})
      .bindPopup(
        "<table class='table table-sm table-bordered'>"
        + "<tr><th>Name</th><td>" + d.name + " / " + d.byondkey + "</td></tr>"
        + "<tr><th>Job</th><td>"  + d.job  + "</td></tr>"
        + "<tr><th>At</th><td>"   + d.pod  + "</td></tr>"
        + "<tr><th>Time</th><td>" + d.tod  + "</td></tr>"
        + "</table>"
      )
      .addTo(corpses);
  });
}

function renderBombs() {
  bombs.clearLayers();
  if (!bombsData) return;
  bombsData.forEach(function(e) {
    if (parseInt(e.z) !== activeGameZ) return;
    if (e.flash > 0) L.circle(tg2leaf(e.x-.5, e.y-.5), {color:'white', radius:+e.flash+.5}).bindPopup("Flash: " + e.flash + " at " + e.area).addTo(bombs);
    if (e.light > 0) L.circle(tg2leaf(e.x-.5, e.y-.5), {color:'yellow',radius:+e.light+.5}).bindPopup("Light: " + e.light + " at " + e.area).addTo(bombs);
    if (e.heavy > 0) L.circle(tg2leaf(e.x-.5, e.y-.5), {color:'orange',radius:+e.heavy+.5}).bindPopup("Heavy: " + e.heavy + " at " + e.area).addTo(bombs);
    if (e.dev   > 0) L.circle(tg2leaf(e.x-.5, e.y-.5), {color:'red',   radius:+e.dev  +.5}).bindPopup("Dev: "   + e.dev   + " at " + e.area).addTo(bombs);
  });
}

function renderLogLayer(filename) {
  if (!logLayers[filename] || !logRawData[filename]) return;
  logLayers[filename].clearLayers();
  logRawData[filename].forEach(function(line) {
    if (parseInt(line.z) !== activeGameZ) return;
    L.polygon([
      tg2leaf(line.x,   line.y),
      tg2leaf(line.x-1, line.y),
      tg2leaf(line.x-1, line.y-1),
      tg2leaf(line.x,   line.y-1)
    ], {color: '#' + line.color})
      .bindPopup(line.text)
      .addTo(logLayers[filename]);
  });
}

fetch('/rounds/' + roundID + '?format=json')
  .then(r => r.json())
  .then(function(data) {

    // ── Webmap config ─────────────────────────────────────────────────────────
    let tilesBase = null;
    let zLevels   = [1];
    let zNames    = ['Station'];
    let gameZMap  = [2];   // gameZMap[i] = game db z for zLevels[i]

    if (data.webmap) {
      if (data.webmap.tiles)    tilesBase = data.webmap.tiles;
      if (data.webmap.main_z)   activeZ   = data.webmap.main_z;
      if (data.webmap.z_levels) zLevels   = data.webmap.z_levels;
      if (data.webmap.z_names)  zNames    = data.webmap.z_names;
      if (data.webmap.game_z)   gameZMap  = data.webmap.game_z;
    }

    // Bounds match our tile pyramid: [[-256,0],[0,256]] covers the 255×255 map.
    var tileBounds = [[-256, 0], [0, 256]];

    // ── Leaflet map init ──────────────────────────────────────────────────────
    map = L.map("map", {
      attributionControl: true,
      minZoom: 0,
      maxZoom: 7,
      maxBounds: [[-300, -50], [50, 305]],
      crs: L.CRS.Simple,
      preferCanvas: true,
    }).setView([-128, 128], 2);

    function switchTileLayer(z) {
      activeZ = z;
      var zIdx = zLevels.indexOf(z);
      activeGameZ = (zIdx >= 0 && gameZMap[zIdx] !== undefined) ? gameZMap[zIdx] : z;

      // Swap base tile layer
      if (tileLayer) map.removeLayer(tileLayer);
      if (tilesBase) {
        tileLayer = L.tileLayer(tilesBase + '/' + z + '/{z}/{x}/{y}.png', {
          tileSize: 256,
          minZoom: 0,
          maxZoom: 7,
          maxNativeZoom: 5,
          tms: false,
          bounds: tileBounds,
          noWrap: true,
          attribution: 'Map tiles: HippieStation (self-hosted)'
        }).addTo(map);
      } else if (data.map_url) {
        tileLayer = L.tileLayer(
          'https://renderbus.s3.amazonaws.com/tiles/' + data.map_url + '/{z}/tile_{x}-{y}.png',
          { minZoom: 1, maxZoom: 6, maxNativeZoom: 5, continuousWorld: true }
        ).addTo(map);
      }

      // Re-render overlays for new z-level (only if their data is loaded)
      if (deathsData && map.hasLayer(corpses)) renderDeaths();
      if (bombsData  && map.hasLayer(bombs))   renderBombs();
      Object.keys(logRawData).forEach(function(filename) {
        if (map.hasLayer(logLayers[filename])) renderLogLayer(filename);
      });

      // Update sidebar button states
      document.querySelectorAll('.zlevel-btn').forEach(function(btn) {
        btn.classList.toggle('active', parseInt(btn.dataset.z) === z);
      });
    }

    // ── Z-level sidebar buttons ───────────────────────────────────────────────
    zLevels.forEach(function(z, i) {
      let name = zNames[i] || ('Z' + z);
      let btn = document.createElement('li');
      btn.className = 'nav-item';
      btn.innerHTML = "<a href='#' class='nav-link zlevel-btn' data-z='" + z + "'>"
        + "<i class='fas fa-layer-group'></i> " + name + "</a>";
      document.getElementById('zlevel-btns').appendChild(btn);
    });

    document.getElementById('zlevel-btns').addEventListener('click', function(e) {
      let btn = e.target.closest('.zlevel-btn');
      if (!btn) return;
      e.preventDefault();
      switchTileLayer(parseInt(btn.dataset.z));
    });

    switchTileLayer(activeZ);

    if (data.deaths) {
      document.getElementById('deaths').classList.remove('invisible');
      document.getElementById('deathCount').textContent = data.deaths;
    }
    if (data.stats && ('explosion' in data.stats)) {
      document.getElementById('bombs').classList.remove('invisible');
    }

    // ── Log file overlays ─────────────────────────────────────────────────────
    fetch('/rounds/' + roundID + '/logs?format=json')
      .then(r => r.json())
      .then(function(logIndex) {
        Object.keys(logIndex).forEach(function(key) {
          let filename = key.includes('.zip/') ? key.split('.zip/')[1] : key;
          document.getElementById('logfiles').insertAdjacentHTML('beforeend',
            "<li class='nav-item'><a href='" + filename + "' class='nav-link logfileLink'>"
            + filename + "</a></li>");
          logLayers[filename] = L.layerGroup();
        });

        document.body.addEventListener('click', function(e) {
          let link = e.target.closest('.logfileLink');
          if (!link) return;
          e.preventDefault();
          link.classList.toggle('active');
          let file = link.getAttribute('href');
          if (!logLayers[file]) return;

          // Data already fetched — just toggle visibility
          if (logRawData[file]) {
            if (map.hasLayer(logLayers[file])) {
              map.removeLayer(logLayers[file]);
            } else {
              renderLogLayer(file);   // re-render for current z before showing
              map.addLayer(logLayers[file]);
            }
            return;
          }

          // First load: fetch then render for current z
          fetch('/rounds/' + roundID + '/logs/' + file + '/json')
            .then(r => r.json())
            .then(function(lines) {
              logRawData[file] = lines;
              renderLogLayer(file);
              map.addLayer(logLayers[file]);
            });
        });
      });

    // ── Deaths overlay ────────────────────────────────────────────────────────
    document.getElementById('deaths').addEventListener('click', function(e) {
      e.preventDefault();
      this.classList.toggle('active');

      if (deathsData) {
        if (map.hasLayer(corpses)) { map.removeLayer(corpses); } else { map.addLayer(corpses); }
        return;
      }

      fetch('/deaths/round/' + roundID + '?format=json')
        .then(r => r.json())
        .then(function(deaths) {
          deathsData = deaths;
          renderDeaths();
          corpses.addTo(map);
        });
    });

    // ── Explosions overlay ────────────────────────────────────────────────────
    document.getElementById('bombs').addEventListener('click', function(e) {
      e.preventDefault();
      this.classList.toggle('active');

      if (bombsData) {
        if (map.hasLayer(bombs)) { map.removeLayer(bombs); } else { map.addLayer(bombs); }
        return;
      }

      fetch('/rounds/' + roundID + '/explosion?format=json')
        .then(r => r.json())
        .then(function(result) {
          bombsData = Object.values(result.data || result);
          renderBombs();
          bombs.addTo(map);
        });
    });
  });
</script>
{% endblock %}
