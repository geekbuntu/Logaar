<script src="static/js/visualize.jQuery.js  " type="text/javascript"></script>

<img id="help" src="static/help.png" rel="div#help_ovr" title="Help">
<div id="help_ovr">
    <h4>Contextual help: Manage</h4>
    <p>TODO</p>
    <p>Here some nice Lorem ipsum:</p>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
    <br/>
    <p>Press ESC to close this window</p>
</div>



<!-- traffic chart-->


<style>
    div#vertgraph {
        width: 378px;
        height: 220px;
        padding: 10px;
        position: relative;
        background: url("../static/images/chart-back.png") no-repeat;
    }
    div#vertgraph ul {
        width: 378px;
        height: 207px;
        margin: 0;
        list-style-type: none;
    }
    div#vertgraph ul li {
        position: absolute;
        width: 4px;
        height: 160px;
        bottom: 41px;
        padding: 0 !important;
        margin: 0 !important;
        background: url("static/images/bar.png") repeat-x;
        border: 1px solid #888;
        font-size: 8pt;
        font-weight: bold;
    }
    div#vertgraph ul li#missing {
        border: 1px solid #a2a;
        background: #fff;
        font-size: 8pt;
        font-weight: bold;
    }
    div#vertgraph ul li span {
        display: none;
        position: absolute;
        left: -20px;
        top: -27px;
        width: 47px;
        height: 21px;
        text-align: center;
        padding-top: 4px;
        background: url("/static/images/chart-hoverbg.png") no-repeat;
        z-index: 255;
    }
    div#vertgraph ul li:hover span {
        display: block;
    }
    div#vertgraph div#title {
        color: #333;
        position: absolute;
        top: 3px;
        left: 5px;
        font-size: 12pt;
    }
    div#vertgraph div#xleft, div#xcaption, div#xright {
        color: white;
        position: absolute;
    }
    div#vertgraph div#xcaption {
        top: 200px;
        text-align: center;
        width: 377px;
        font-size: 8pt;
    }
    div#vertgraph div#xleft,div#xright {
        top: 185px;
        font-size: 7pt;
        font-weight: bold;
    }
    div#vertgraph div#xleft { left: 8px; }
    div#vertgraph div#xright { right: 8px; }
    div#vertgraph div#ylabel {
        color: #777;
        position: absolute;
        font-size: 8pt;
        padding-left: 4px;
    }

div.hbar {
    border: 1px solid #8888cc;
}

</style>



<div style="width: 378px; height: 220px;" id="vertgraph">
    <div id="title">Traffic</div>
    <div id="ylabel" style="top: 27px;">{{traffic.ymax}}</div>
    <div id="ylabel" style="top: 172px;">{{traffic.ymin}}</div>
    <ul>
        % for dt, value in traffic.series:
        <li style="left: {{dt*6}}px; height: {{value*1}}px;"><span>{{value}}</span></li>
        % end
    </ul>

</div>

<h3>Top talkers</h3>
<table id="top_talkers">
    <thead>
        <tr>
            <th>Name</th>
            <th>Name</th>
        </tr>
    </thead>
% mi = min(x[0] for x in top_talkers.toplist)
% delta = max(x[0] for x in top_talkers.toplist) - mi
% if delta:
%     delta = 300.0 / delta
% for n, name in top_talkers.toplist:
    <tr>
        <td>{{name}}</td>
        <td>
            <div class="hbar" style="width: {{(n - mi) * delta}}px">
                {{n}}
            </div>
        </td>
    </tr>
% end
</table>

<h3>Top programs</h3>
<table id="top_programs">
    <thead>
        <tr>
            <th>Name</th>
            <th>Name</th>
        </tr>
    </thead>
% #mi = min(x[0] for x in top_programs.toplist)
% mi = min(x[0] for x in top_programs.toplist)
% delta = max(x[0] for x in  top_programs.toplist) - mi
% if delta:
%     delta = 300.0 / delta
% for n, name in top_programs.toplist:
    <tr>
        <td>{{name}}</td>
        <td>
            <div class="hbar" style="width: {{(n - mi) * delta}}px">
                {{n}}
            </div>
        </td>
    </tr>
% end
</table>


<!--

<div style="width: 378px; height: 220px;" id="vertgraph">
    <div id="title">${title}</div>
    <div id="ylabel" style="top: 172px;">0</div>
    <div id="ylabel" style="top: 143px;">${ylabels[0]}</div>
    <div id="ylabel" style="top: 114px;">${ylabels[1]}</div>
    <div id="ylabel" style="top: 85px;">${ylabels[2]}</div>
    <div id="ylabel" style="top: 56px;">${ylabels[3]}</div>
    <div id="ylabel" style="top: 27px;">${ylabels[4]}</div>
    <ul>
        <li py:for="left, height,value,id in values" style="id='${id}'; left: ${left}px; height: ${height}px;"><span>${value}</span></li>
    </ul>
    <div id="xleft">${xlabels[0]}</div>
    <div id="xright">${xlabels[2]}</div>
    <div id="xcaption">${xlabels[1]}</div>
</div>

-->




<script type="text/javascript">
$(function() {
}
</script>
