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
let activeZ = 2;      // default z-level shown on the map
let tileLayer = null;
let map = null;

fetch('/rounds/' + roundID + '?format=json')
  .then(r => r.json())
  .then(function(data) {

    // ── Webmap config ─────────────────────────────────────────────────────────
    // tiles: base URL to the self-hosted XYZ tile pyramid served by Caddy.
    //   Tile URL pattern: {tilesBase}/{z_level}/{zoom}/{x}/{y}.png
    //   e.g.  https://webmap.owo.fm/hippiestation/2/4/3/5.png
    let tilesBase = null;
    let zLevels   = [2];
    let zNames    = ['Station'];

    if (data.webmap) {
      if (data.webmap.tiles)    tilesBase = data.webmap.tiles;
      if (data.webmap.main_z)   activeZ   = data.webmap.main_z;
      if (data.webmap.z_levels) zLevels   = data.webmap.z_levels;
      if (data.webmap.z_names)  zNames    = data.webmap.z_names;
    }

    // Leaflet CRS.Simple tile coordinate system:
    //   bounds [[-256,0],[0,256]] — one 256-unit square.
    //   At zoom Z there are 2^Z × 2^Z tiles of 256 px each.
    //   Tile (0,0) = top-left (north-west = high BYOND Y, low BYOND X).
    //   tg2leaf(x,y) → [y-255, x]  so the top-left corner is [-255, 0]
    //   and the bottom-right is [0, 255].  We pad the bounds by 1 unit so
    //   tile edges exactly align with the map boundary.
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
      if (tileLayer) map.removeLayer(tileLayer);
      if (tilesBase) {
        // Self-hosted XYZ tiles rendered by dmm-tools + tile.py
        // URL: {tilesBase}/{z_level}/{zoom}/{x}/{y}.png
        tileLayer = L.tileLayer(tilesBase + '/' + z + '/{z}/{x}/{y}.png', {
          tileSize: 256,
          minZoom: 0,
          maxZoom: 7,
          maxNativeZoom: 5,   // tiles rendered up to zoom 5; zoom 6-7 upscales
          tms: false,          // y=0 is north (top), matching our tile.py output
          bounds: tileBounds,
          noWrap: true,
          attribution: 'Map tiles: HippieStation (self-hosted)'
        }).addTo(map);
      } else if (data.map_url) {
        // Legacy renderbus tile fallback
        tileLayer = L.tileLayer(
          'https://renderbus.s3.amazonaws.com/tiles/' + data.map_url + '/{z}/tile_{x}-{y}.png',
          { minZoom: 1, maxZoom: 6, maxNativeZoom: 5, continuousWorld: true }
        ).addTo(map);
      }

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

    // Load default z-level
    switchTileLayer(activeZ);

    if (data.deaths) {
      document.getElementById('deaths').classList.remove('invisible');
      document.getElementById('deathCount').textContent = data.deaths;
    }
    if (data.stats && data.stats.explosion) {
      document.getElementById('bombs').classList.remove('invisible');
    }

    // ── Log file overlays ─────────────────────────────────────────────────────
    fetch('/rounds/' + roundID + '/logs?format=json')
      .then(r => r.json())
      .then(function(logData) {
        let logLayers = {};
        // Keys are plain filenames (local mode) or legacy "path.zip/filename" strings
        Object.keys(logData).forEach(function(key) {
          let filename = key.includes('.zip/') ? key.split('.zip/')[1] : key;
          let html = "<li class='nav-item'><a href='" + filename + "' class='nav-link logfileLink'>" + filename + "</a></li>";
          document.getElementById('logfiles').insertAdjacentHTML('beforeend', html);
          logLayers[filename] = L.layerGroup();
          logLayers[filename]['loaded'] = false;
        });

        document.body.addEventListener('click', function(e) {
          let link = e.target.closest('.logfileLink');
          if (!link) return;
          e.preventDefault();
          link.classList.toggle('active');
          let file = link.getAttribute('href');
          if (!logLayers[file]) return;
          if (logLayers[file]['loaded']) {
            if (map.hasLayer(logLayers[file])) {
              map.removeLayer(logLayers[file]);
            } else {
              map.addLayer(logLayers[file]);
            }
            return;
          }
          fetch('/rounds/' + roundID + '/logs/' + file + '/json')
            .then(r => r.json())
            .then(function(lines) {
              lines.forEach(function(line) {
                if (parseInt(line.z) !== activeZ) return;
                L.polygon([
                  tg2leaf(line.x,   line.y),
                  tg2leaf(line.x-1, line.y),
                  tg2leaf(line.x-1, line.y-1),
                  tg2leaf(line.x,   line.y-1)
                ], {color: '#' + line.color})
                  .bindPopup(line.text)
                  .addTo(logLayers[file]);
              });
              logLayers[file]['loaded'] = true;
              logLayers[file].addTo(map);
            });
        });
      });

    // ── Deaths overlay ────────────────────────────────────────────────────────
    var corpses = L.layerGroup();
    var corpsesLoaded = false;
    document.getElementById('deaths').addEventListener('click', function(e) {
      e.preventDefault();
      this.classList.toggle('active');
      if (corpsesLoaded) {
        if (map.hasLayer(corpses)) { map.removeLayer(corpses); } else { map.addLayer(corpses); }
        return;
      }
      corpsesLoaded = true;
      fetch('/deaths/round/' + roundID + '?format=json')
        .then(r => r.json())
        .then(function(deaths) {
          deaths.forEach(function(d) {
            if (parseInt(d.z) !== activeZ) return;
            L.polygon([
              tg2leaf(d.x,   d.y),
              tg2leaf(d.x-1, d.y),
              tg2leaf(d.x-1, d.y-1),
              tg2leaf(d.x,   d.y-1)
            ], {color: 'red'})
              .bindPopup(
                "<table class='table table-sm table-bordered'>"
                + "<tr><th>Name</th><td>" + d.name + " / " + d.byondkey + "</td></tr>"
                + "<tr><th>Job</th><td>" + d.job + "</td></tr>"
                + "<tr><th>At</th><td>" + d.pod + "</td></tr>"
                + "<tr><th>Time</th><td>" + d.tod + "</td></tr>"
                + "</table>"
              )
              .addTo(corpses);
          });
        });
      corpses.addTo(map);
    });

    // ── Explosions overlay ────────────────────────────────────────────────────
    var bombs = L.layerGroup();
    var bombsLoaded = false;
    document.getElementById('bombs').addEventListener('click', function(e) {
      e.preventDefault();
      this.classList.toggle('active');
      if (bombsLoaded) {
        if (map.hasLayer(bombs)) { map.removeLayer(bombs); } else { map.addLayer(bombs); }
        return;
      }
      bombsLoaded = true;
      fetch('/rounds/' + roundID + '/explosion?format=json')
        .then(r => r.json())
        .then(function(result) {
          Object.values(result.data || result).forEach(function(e) {
            if (String(e.z) !== String(activeZ)) return;
            if (e.flash > 0) L.circle(tg2leaf(e.x-.5, e.y-.5), {color:'white', radius:+e.flash+.5}).bindPopup("Flash: " + e.flash + " at " + e.area).addTo(bombs);
            if (e.light > 0) L.circle(tg2leaf(e.x-.5, e.y-.5), {color:'yellow',radius:+e.light+.5}).bindPopup("Light: " + e.light + " at " + e.area).addTo(bombs);
            if (e.heavy > 0) L.circle(tg2leaf(e.x-.5, e.y-.5), {color:'orange',radius:+e.heavy+.5}).bindPopup("Heavy: " + e.heavy + " at " + e.area).addTo(bombs);
            if (e.dev   > 0) L.circle(tg2leaf(e.x-.5, e.y-.5), {color:'red',   radius:+e.dev  +.5}).bindPopup("Dev: "   + e.dev   + " at " + e.area).addTo(bombs);
          });
        });
      bombs.addTo(map);
    });
  });
</script>
{% endblock %}
