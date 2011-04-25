<script src="static/jquery.tools.min.js" type="text/javascript"></script>

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

    div.spinner {
        margin: 7em auto;
        background: url('static/spinner_big.gif') no-repeat;
        width: 32px;
        height: 32px;
    }

    /* Horizontal container to align the charts */

    div.hcontainer {
        overflow:hidden;
        width:1400px;
    }
    div.hcontainer div.inner {
        overflow:hidden;
        width: 1400px;
    }
    div.hcontainer div.inner div.chartbox {
        float:left;
        width:400px;
        height:250px;
        margin:1em;
    }

</style>

<div class="hcontainer">
    <div class="inner">
        <div id="stats_traffic" class="chartbox">
            <div class="spinner"></div>
        </div>
        <div id="stats_collector_chart" class="chartbox">
            <div class="spinner"></div>
        </div>
        <div id="stats_parser_chart" class="chartbox">
            <div class="spinner"></div>
        </div>
    </div>
</div>

<div class="hcontainer">
    <div class="inner">
        <div id="stats_top_talkers" class="chartbox">
            <div class="spinner"></div>
        </div>
        <div id="stats_top_programs" class="chartbox">
            <div class="spinner"></div>
        </div>
    </div>
</div>


<script type="text/javascript">
$(function() {
    window.setInterval(function() {
        $('div#stats_traffic').load('stats_traffic');
        $('div#stats_collector_chart').load('collector_chart');
        $('div#stats_parser_chart').load('parser_chart');
        $('div#stats_top_programs').load('stats_top_programs');
        $('div#stats_top_talkers').load('stats_top_talkers');
    }, 10000);
});
</script>
