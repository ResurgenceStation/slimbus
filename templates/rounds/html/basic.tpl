{% include('rounds/html/header.tpl') %}

<div class="win95-flex-between" style="margin: 6px 0;">
  <div>
    {% if round.prev %}
      <a class="win95-button" href="{{path_for('round.single',{'id': round.prev})}}">&laquo; Round #{{round.prev}}</a>
    {% endif %}
  </div>
  <div>
    {% if round.next %}
      <a class="win95-button" href="{{path_for('round.single',{'id': round.next})}}">Round #{{round.next}} &raquo;</a>
    {% endif %}
  </div>
</div>

<div class="win95-section">
  <div class="win95-section__title"><span>Basic Details</span></div>
  <div class="win95-section__body">
    <table class="win95-table win95-table--keyvalue">
      <tbody>
        <tr>
          <th>Station Name</th>
          <td>{{round.station_name}}</td>
          <th>Deaths</th>
          <td>
            <a class="win95-button win95-button--sm" href="{{path_for('death.round',{'round': round.id})}}">{{round.deaths}}</a>
            <a class="win95-button win95-button--sm" href="{{path_for('round.map',{'id': round.id})}}">Map</a>
          </td>
        </tr>
        <tr>
          <th>Escape Shuttle</th>
          <td>
            {% if not round.shuttle %}
              <em class="win95-muted">No Escape Shuttle</em>
            {% else %}
              {{round.shuttle}}
            {% endif %}
          </td>
          <th>Logs</th>
          <td>
            {% if round.logs %}
              <a class="win95-button win95-button--sm" href="{{round.remote_logs_dir}}" target="_blank" rel="noopener noreferrer">Original</a>
              {% if round.server_data.demo_viewer is defined and round.server_data.demo_viewer %}
                <a class="win95-button win95-button--sm" href="{{round.server_data.demo_viewer}}/?demo_url={{round.remote_logs_dir|trim('/')}}/demo.log" target="_blank" rel="noopener noreferrer">Replay</a>
              {% endif %}
              {% if user.canAccessTGDB %}
                <a class="win95-button win95-button--sm" href="{{round.admin_logs_dir}}" target="_blank" rel="noopener noreferrer">Admin</a>
              {% endif %}
              {% include 'rounds/html/extraLinks.tpl' ignore missing %}
            {% else %}
              <em class="win95-muted">Not available</em>
            {% endif %}
          </td>
        </tr>
        {% if round.logs %}
        <tr>
          <th colspan="2">Logs By Statbus</th>
          <td colspan="2">
            <a class="win95-button win95-button--sm" href="{{path_for('round.gamelogs',{'id': round.id})}}">Collated Game &amp; Attack</a>
            <a class="win95-button win95-button--sm" href="{{path_for('round.logs',{'id': round.id})}}">Log File Listing</a>
            {% if round.data.newscaster_stories %}
              <a class="win95-button win95-button--sm" href="{{path_for('round.log',{'id': round.id,'file':'newscaster.json'})}}">News Stories</a>
            {% endif %}
          </td>
        </tr>
        {% endif %}
      </tbody>
    </table>
  </div>
</div>

<div class="win95-section">
  <div class="win95-section__title"><span>Technical Details</span></div>
  <div class="win95-section__body">
    <table class="win95-table win95-table--keyvalue" id="technical">
      <tbody>
        <tr>
          <th>Round Duration</th>
          <td>{{round.duration}}</td>
          {% if round.commit_hash %}
            <th>Commit</th>
            <td>
              <a class="win95-button win95-button--sm win95-mono" href="{{round.commit_href}}" target="_blank" rel="noopener noreferrer">{{round.commit_hash}}</a>
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
          <td class="win95-mono">{{round.initialize_datetime}}</td>
          <th>End Time</th>
          <td class="win95-mono">
            {# Three-tier end-time display, matching upstream Statbus. #}
            {% if round.end_datetime and round.shutdown_datetime %}
              {{round.end_datetime}}
              <small class="win95-muted">Shutdown: {{round.shutdown_datetime}}</small>
            {% elseif round.shutdown_datetime %}
              {{round.shutdown_datetime}}
              <small class="win95-muted">(end_datetime not recorded)</small>
            {% else %}
              <span class="win95-muted">Server crashed &mdash; no end timings</span>
            {% endif %}
          </td>
        </tr>
        <tr>
          {% if round.data.byond_version %}
            <th>Byond Version</th>
            <td>{{round.data.byond_version.json}}</td>
          {% endif %}
          {% if round.data.byond_build %}
            <th>Byond Build</th>
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
  </div>
</div>
