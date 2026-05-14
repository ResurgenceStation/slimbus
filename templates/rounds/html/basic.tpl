{% include('rounds/html/header.tpl') %}

{# Previous / Next round navigation. PDA buttons. #}
<div class="pda-round-nav">
  <div class="pda-round-nav__prev">
    {% if round.prev %}
    <a class="pda-button" href="{{path_for('round.single',{'id': round.prev})}}">
      <i class='fas fa-angle-left'></i> <i class='fa fa-circle'></i> {{round.prev}}
    </a>
    {% endif %}
  </div>
  <div class="pda-round-nav__next">
    {% if round.next %}
    <a class="pda-button" href="{{path_for('round.single',{'id': round.next})}}">
      <i class='fa fa-circle'></i> {{round.next}} <i class='fas fa-angle-right'></i>
    </a>
    {% endif %}
  </div>
</div>

<h2>Basic Details</h2>
<table class="pda-table pda-table--keyvalue">
  <tbody>
    <tr>
      <th>Station Name</th>
      <td>{{round.station_name}}</td>
      <th>Deaths</th>
      <td>
        <a class="pda-button" href="{{path_for('death.round',{'round': round.id})}}">{{round.deaths}}</a>
        <a class="pda-button" href="{{path_for('round.map',{'id': round.id})}}">Map</a>
      </td>
    </tr>
    <tr>
      <th>Escape Shuttle</th>
      <td>
        {% if not round.shuttle %}
          <em class="text-muted">No Escape Shuttle</em>
        {% else %}
          {{round.shuttle}}
        {% endif %}
      </td>
      <th>Logs</th>
      <td>
        {% if round.logs %}
          <a class="pda-button" href="{{round.remote_logs_dir}}" target="_blank" rel="noopener noreferrer">
            Original <i class="fas fa-external-link-alt"></i>
          </a>
          {% if round.server_data.demo_viewer is defined and round.server_data.demo_viewer %}
          <a class="pda-button" href="{{round.server_data.demo_viewer}}/?demo_url={{round.remote_logs_dir|trim('/')}}/demo.log" target="_blank" rel="noopener noreferrer">
            Watch Replay <i class="fas fa-external-link-alt"></i>
          </a>
          {% endif %}
          {% if user.canAccessTGDB %}
            <a class="pda-button" href="{{round.admin_logs_dir}}" target="_blank" rel="noopener noreferrer">
              Original <i class="fas fa-external-link-alt"></i>
            </a>
          {% endif %}
          {% include 'rounds/html/extraLinks.tpl' ignore missing %}
        {% else %}
          <em class="text-muted">Not available</em>
        {% endif %}
      </td>
    </tr>
    {% if round.logs %}
    <tr>
      <th colspan="2">Logs By Statbus</th>
      <td colspan="2">
        <a class="pda-button pda-button--accent" href="{{path_for('round.gamelogs',{'id': round.id})}}">Collated Game &amp; Attack Logs</a>
        <a class="pda-button pda-button--accent" href="{{path_for('round.logs',{'id': round.id})}}">Log File Listing</a>
        {% if round.data.newscaster_stories %}
        <a class="pda-button pda-button--accent" href="{{path_for('round.log',{'id': round.id,'file':'newscaster.json'})}}">News Stories</a>
        {% endif %}
      </td>
    </tr>
    {% endif %}
  </tbody>
</table>

<h2 data-target="#technical" data-toggle="collapse">Technical Details</h2>
<table class="pda-table pda-table--keyvalue" id="technical">
  <tbody>
    <tr>
      <th>Round Duration</th>
      <td>{{round.duration}}</td>
      {% if round.commit_hash %}
      <th>Commit</th>
      <td>
        <a class="pda-button" href="{{round.commit_href}}" target="_blank" rel="noopener noreferrer">
          <code>{{round.commit_hash}}</code> <i class="fas fa-external-link-alt"></i>
        </a>
      </td>
      {% endif %}
    </tr>
    <tr>
      <th>Initialization Duration</th>
      <td>{{round.init_time}}</td>
      <th>Shutdown Duration</th>
      <td>{{round.shutdown_time}}</td>
    </tr>
    <tr>
      <th>Initialization Time</th>
      <td>{{round.initialize_datetime}}</td>
      <th>End Time</th>
      <td>
        {# Three-tier end-time display, matching upstream Statbus (Stage 0). #}
        {% if round.end_datetime and round.shutdown_datetime %}
          {{round.end_datetime}}
          <small class="d-block text-muted">Shutdown: {{round.shutdown_datetime}}</small>
        {% elseif round.shutdown_datetime %}
          {{round.shutdown_datetime}}
          <small class="d-block text-muted">(end_datetime not recorded, shown is shutdown_datetime)</small>
        {% else %}
          <span class="pda-tag pda-tag--err"><i class="fas fa-skull-crossbones"></i> Server crashed - No end timings</span>
        {% endif %}
      </td>
    </tr>
    <tr>
      {% if round.data.byond_version %}
      <th>BYOND Version</th>
      <td>{{round.data.byond_version.json}}</td>
      {% endif %}
      {% if round.data.byond_build %}
      <th>BYOND Build</th>
      <td>{{round.data.byond_build.json}}</td>
      {% endif %}
    </tr>
    <tr>
      {% if round.data.dm_version %}
      <th>DM Version</th>
      <td>{{round.data.dm_version.json}}</td>
      {% endif %}
      {% if round.data.byond_build %}
      <th>Random Seed</th>
      <td>{{round.data.random_seed.json}}</td>
      {% endif %}
    </tr>
  </tbody>
</table>
