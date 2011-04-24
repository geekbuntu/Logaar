

<style>
    div#vertgraph {
        width: 378px;
        height: 220px;
        margin: 10px;
        padding: 10px;
        position: relative;
        background: url("../static/images/chart-back.png") no-repeat;
    }
    div#vertgraph ul {
        margin: 0;
        list-style-type: none;
    }
    div#vertgraph ul li {
        position: absolute;
        width: 4px;
        height: 160px;
        bottom: 61px;
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
        % delta = traffic.ymax - traffic.ymin
        % for dt, value in traffic.series:
        <li style="left: {{dt*6 + 11}}px; height: {{int(value * 145 / delta)}}px;"><span>{{value}}</span></li>
        % end
    </ul>

</div>



