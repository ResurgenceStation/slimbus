{% include('rounds/html/header.tpl') %}

<div class="win95-flex-between" style="margin: 6px 0 14px;">
  <div>
    {% if round.prev %}
      <a class="win95-button" href="{{path_for('round.single',{'id': round.prev})}}"><i class="fas fa-angle-left"></i> <i class="fas fa-circle"></i> {{round.prev}}</a>
    {% endif %}
  </div>
  <div>
    {% if round.next %}
      <a class="win95-button" href="{{path_for('round.single',{'id': round.next})}}"><i class="fas fa-circle"></i> {{round.next}} <i class="fas fa-angle-right"></i></a>
    {% endif %}
  </div>
</div>

<div class="win95-section">
  <div class="win95-section__title"><span><i class="fas fa-info-circle"></i> Basic Details</span></div>
  <div class="win95-section__body">
    <table class="win95-table win95-table--keyvalue">
      <tbody>
        <tr>
          <th>Station Name</th>
          <td>{{round.station_name}}</td>
          <th>Deaths</th>
          <td>
            <a class="win95-button win95-button--sm" href="{{path_for('death.round',{'round': round.id})}}"><i class="fas fa-user-times"></i> {{round.deaths}}</a>
            <a class="win95-button win95-button--sm" href="{{path_for('round.map',{'id': round.id})}}"><i class="fas fa-map"></i> Map</a>
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
              <a class="win95-button win95-button--sm" href="{{round.remote_logs_dir}}" target="_blank" rel="noopener noreferrer"><i class="fas fa-folder-open"></i> Original <i class="fas fa-external-link-alt"></i></a>
              {% if round.server_data.demo_viewer is defined and round.server_data.demo_viewer %}
                <a class="win95-button win95-button--sm" href="{{round.server_data.demo_viewer}}/?demo_url={{round.remote_logs_dir|trim('/')}}/demo.log" target="_blank" rel="noopener noreferrer"><i class="fas fa-play-circle"></i> Watch Replay <i class="fas fa-external-link-alt"></i></a>
              {% endif %}
              {% if user.canAccessTGDB %}
                <a class="win95-button win95-button--sm" href="{{round.admin_logs_dir}}" target="_blank" rel="noopener noreferrer"><i class="fas fa-shield-alt"></i> Admin <i class="fas fa-external-link-alt"></i></a>
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
            <a class="win95-button win95-button--sm" href="{{path_for('round.gamelogs',{'id': round.id})}}"><i class="fas fa-list"></i> Collated Game &amp; Attack</a>
            <a class="win95-button win95-button--sm" href="{{path_for('round.logs',{'id': round.id})}}"><i class="fas fa-folder"></i> Log File Listing</a>
            {% if round.data.newscaster_stories %}
              <a class="win95-button win95-button--sm" href="{{path_for('round.log',{'id': round.id,'file':'newscaster.json'})}}"><i class="far fa-newspaper"></i> News Stories</a>
            {% endif %}
          </td>
        </tr>
        {% endif %}
      </tbody>
    </table>
  </div>
</div>

<div class="win95-section">
  <div class="win95-section__title"><span><i class="fas fa-cog"></i> Technical Details</span></div>
  <div class="win95-section__body">
    <table class="win95-table win95-table--keyvalue" id="technical">
      <tbody>
        <tr>
          <th>Round Duration</th>
          <td><i class="fas fa-stopwatch"></i> {{round.duration}}</td>
          {% if round.commit_hash %}
            <th>Commit</th>
            <td>
              <a class="win95-button win95-button--sm win95-mono" href="{{round.commit_href}}" target="_blank" rel="noopener noreferrer"><i class="fab fa-git-alt"></i> {{round.commit_hash}} <i class="fas fa-external-link-alt"></i></a>
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
            {# Three-tier end-time display, each timestamp on its own line. #}
            {% if round.end_datetime %}
              <div>{{round.end_datetime}}</div>
            {% endif %}
            {% if round.shutdown_datetime %}
              <div class="win95-muted" style="font-size:11px;">Shutdown: {{round.shutdown_datetime}}</div>
            {% endif %}
            {% if not round.end_datetime and not round.shutdown_datetime %}
              <span class="win95-muted"><i class="fas fa-skull-crossbones"></i> Server crashed</span>
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
