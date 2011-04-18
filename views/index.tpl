<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="content-type">
%if not logged_in:
<div>
    <h2>Login</h2>
    <p>Please insert your credentials:</p>
    <form action="login" method="post">
        <input type="text" name="user" />
        <input type="password" name="pwd" />
        <br/><br/>
        <button type="submit" > OK </button>
        <button type="button" class="close"> Cancel </button>
    </form>
    <br />
</div>

<style type="text/css">
div {
    color: #777;
    margin: auto;
    width: 20em;
    text-align: center;
}
input {
    background: #f8f8f8;
    border: 1px solid #777;
    margin: auto;
}
input:hover { background: #fefefe}
</style>
%end
%if logged_in:
<title>Logaar</title>

<script src="static/jquery.tools.min.js" type="text/javascript"></script>
<script src="static/jquery.dataTables.js" type="text/javascript"></script>


<style media="screen" type="text/css">

/* root element for tabs  */
ul.css-tabs {
    margin:0 !important;
    padding:0;
    height:30px;
    border-bottom:1px solid #666;
}

/* single tab */
ul.css-tabs li {
    float:left;
    padding:0;
    margin:0;
    list-style-type:none;
}

/* link inside the tab. uses a background image */
ul.css-tabs a {
    font-size:13px;
    display:block;
    padding: 5px 30px;
    text-decoration:none;
    border: 1px solid #666;
    border-bottom: 0;
    height: 18px;
    background-color: #efefef;
    color:#777;
    margin-left: 2px;
    border-top-left-radius: 4px;
    border-top-right-radius: 4px;
    -moz-border-radius-topleft: 4px;
    -moz-border-radius-topright: 4px;
    position:relative;
    top:1px;
}

ul.css-tabs a:hover {
    background-color:#F7F7F7;
    color:#333;
}

/* selected tab */
ul.css-tabs a.current {
    background-color:#eee;
    border-bottom:2px solid #eee;
    color:#000;
    cursor:default;
}

/* tab pane
*/
.tabpane div {

    background-color:#eee;
}

#pageLogin {
    font-size: 10px;
    font-family: verdana;
    text-align: right;
}

html, body {
  color: black;
  background-color: white;
  font: x-small "Lucida Grande", "Lucida Sans Unicode", geneva, verdana, sans-serif;
  margin: 0;
  padding: 0;
}

#header {
  height: 36px;
  width: 100%;
  background: #5ec2dd URL('static/header_inner.png') no-repeat;
  margin: 0 auto 0 auto;
}

#header div {
    color: #eef;
    text-align: right;
    padding: 8px 8px 0 0;
    font-size: 150%;
    font-weight: bold;
}

a.link, a, a.active {
  color: #369;
}

#main_content {
  color: black;
  font-size: 127%;
  background-color: white;
  width: 818px;
  margin: 0 auto 0 auto;
  border-left: 1px solid #aaa;
  border-right: 1px solid #aaa;
  padding: 10px;
}

#footer {
  color: #999;
  padding: .5em;
  font-size: 90%;
  text-align: center;
  width: 818px;
  margin: 0 auto 2px auto;
}

.code {
  font-family: monospace;
}

span.code {
  font-weight: bold;
  background: #eee;
}

.fielderror {
    color: red;
    font-weight: bold;
}

table td{
    border-color: #ddd;
    border-width: 0 1px 1px 0;
    border-style: solid;
    vertical-align: center;
}

table td:hover {
    background-color: #f4f4f4;
}

table td.hea {
    width: 200px;
}

table td.hea:hover {
    background-color: #eee;
}

table td img {
    margin: 1px;
}

table td {
    padding: 0 .5em 0 .5em;
}


.diff_chg {
    color: red;
    font-weight:bold;}
}
div#msgpane {
    width: 100%;
}
div#msgpane table {
    width: 100%;
}
.tooltip {
    display:none;
    background-color:#ffa;
    border:1px solid #cc9;
    padding:3px;
    font-size:13px;
    -moz-box-shadow: 2px 2px 11px #666;
    -webkit-box-shadow: 2px 2px 11px #666;
}

div#savereset {
    position: absolute;
    top: 50px;
    right: 20px;
}

.modal {
    background-color:#fff;
    display:none;
    width: 18em;
    padding:2em;
    text-align:left;
    border:2px solid #333;

    opacity:0.8;
    -moz-border-radius:6px;
    -webkit-border-radius:6px;
    -moz-box-shadow: 0 0 50px #ccc;
    -webkit-box-shadow: 0 0 50px #ccc;
}

div#editing_form {
    background-color:#fff;
    display:none;
    width:350px;
    padding:15px;
    text-align:left;
    border:2px solid #333;

    opacity:0.8;
    -moz-border-radius:6px;
    -webkit-border-radius:6px;
    -moz-box-shadow: 0 0 50px #ccc;
    -webkit-box-shadow: 0 0 50px #ccc;
}

input {
    background: #fafafa;
    border: 1px solid #333
}

input:hover { background: #fff}

// Message pane
div#msgpane {
    height:10em;
    overflow:auto;
}
div#msgslot {
    height:10em;
    overflow:auto;
}

table#msgs tr td.hea {
    width: 20px;
    vertical-align:middle;
}
table#msgs tr td.ts { width: 5em; }

div#gradient {
 border-top: 1px solid #ccc;
  position: relative;
  top: 15px;
  height: 15px;
  width: 100%;
  background: url('static/gradient.png') repeat-x;
  z-index: 4000;
}


/* tab-content styling */

img#help { float: right; }
div#help_ovr {
    background-color:#fff;
    display:none;
    width: 70em;
    padding:15px;
    text-align:left;
    border:2px solid #333;
    opacity:0.98;
    -moz-border-radius:6px;
    -webkit-border-radius:6px;
    -moz-box-shadow: 0 0 50px #ccc;
    -webkit-box-shadow: 0 0 50px #ccc;
}
#triggers img {
    border:0;
    cursor:pointer;
    margin-left:11px;
}

/* Form validation error message */

.error {
    z-index: 30055;
    height:15px;
    background-color: #eeeeff;
    border:1px solid #000;
    font-size:11px;
    color:#000;
    padding:3px 10px;
    margin-left:20px;


    /* CSS3 spicing for mozilla and webkit */
    -moz-border-radius:4px;
    -webkit-border-radius:4px;
    -moz-border-radius-bottomleft:0;
    -moz-border-radius-topleft:0;
    -webkit-border-bottom-left-radius:0;
    -webkit-border-top-left-radius:0;

    -moz-box-shadow:0 0 6px #ddd;
    -webkit-box-shadow:0 0 6px #ddd;
}
div#multisel {
    margin: 0;
    padding: 0.1em;
    display: block;
    border: 0;
    background-color: transparent;
}
div#multisel div#selected {
    margin: 0 0 0 4em;
    padding: 0 2px 0 2px;
    display: block;
    border: 1px #333 solid;
    width: 20em;
    background: #fafafa;
}
div#multisel div#selected p {
    margin: 0;
    padding: 0;
    height: 1em;
    cursor: default;
}
div#multisel div#selected p:hover {
    text-decoration: line-through;
}




/* dynamic table related styling */


table#items {
    margin: 0 .7em;
}


table#items thead {
    background: url('static/images/tgrad.png') repeat-x;
}

div#items_filter input {
    border: 1px solid #aaaaaa;
}

table#items thead th {
    border: 1px solid #aaaaaa;
    padding: .2em 1em .2em 1em;
    margin: 0;
    color: #333333;
}

div.dataTables_wrapper div#items_length {
    padding: 0 0 .5em 1em;
}
div.dataTables_wrapper div#items_filter {
    padding: 0 1em 0 0;
}

.dataTables_wrapper {
    min-height: 302px;
    clear: both;
    _height: 302px;
    zoom: 1; /* Feeling sorry for IE */
}

.dataTables_processing {
    position: absolute;
    top: 50%;
    left: 50%;
    width: 250px;
    height: 30px;
    margin-left: -125px;
    margin-top: -15px;
    padding: 14px 0 2px 0;
    border: 1px solid #ddd;
    text-align: center;
    color: #999;
    font-size: 14px;
    background-color: white;
}

div.top {
}

div.top div.dataTables_length {
    float: left;
    width: 33%;
}

div.top div.dataTables_paginate paging_two_button {
    width: 33%;
    float: left;

}

div.top div.dataTables_filter {
    width: 33%;
    float: right;
    text-align: right;
    margin-bottom: 15px;
}

table#items {
    width: 99%;
}

table#items thead tr th {
    width: 10%;
}
div.dataTables_info {
    width: 60%;
    float: left;
    padding: .5em 0 0 1em;
}

div.dataTables_paginate {
    width: 44px;
    * width: 50px;
    float: right;
    text-align: right;
    margin-top:  4px;
    border: 0;
}

/* Pagination nested */
.paginate_disabled_previous, .paginate_enabled_previous, .paginate_disabled_next, .paginate_enabled_next {
    height: 19px;
    width: 19px;
    margin-left: 3px;
    float: left;
}

.paginate_disabled_previous {
    background: url('static/images/back_disabled.png') no-repeat;
}

.paginate_enabled_previous {
    background: url('static/images/back_enabled.png') no-repeat;
}

.paginate_disabled_next {
    background: url('static/images/forward_disabled.png') no-repeat;
}

.paginate_enabled_next {
    background: url('static/images/forward_enabled.png') no-repeat;
}



table.display {
    margin: 0 auto;
    clear: both;
    width: 100%;

    /* Note Firefox 3.5 and before have a bug with border-collapse
     * ( https://bugzilla.mozilla.org/show%5Fbug.cgi?id=155955 )
     * border-spacing: 0; is one possible option. Conditional-css.com is
     * useful for this kind of thing
     *
     * Further note IE 6/7 has problems when calculating widths with border width.
     * It subtracts one px relative to the other browsers from the first column, and
     * adds one to the end...
     *
     * If you want that effect I'd suggest setting a border-top/left on th/td's and
     * then filling in the gaps with other borders.
     */
    border-spacing: 0;
}

table.display thead th {
    padding: 3px 18px 3px 10px;
    border-bottom: 1px solid black;
    font-weight: bold;
    cursor: pointer;
    * cursor: hand;
}

table.display tfoot th {
    padding: 3px 18px 3px 10px;
    border-top: 1px solid black;
    font-weight: bold;
}

table.display tr.heading2 td {
    border-bottom: 1px solid #aaa;
}

table.display td {
    padding: 3px 10px;
}

table.display td.center {
    text-align: center;
}



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * DataTables sorting
 */

.sorting_asc {
    background: url('static/images/sort_asc.png') no-repeat center right;
}

.sorting_desc {
    background: url('static/images/sort_desc.png') no-repeat center right;
}


.sorting_asc_disabled {
    background: url('static/images/sort_asc_disabled.png') no-repeat center right;
}

.sorting_desc_disabled {
    background: url('static/images/sort_desc_disabled.png') no-repeat center right;
}



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * DataTables row classes
 */
table.display tr.odd.gradeA {
    background-color: #ddffdd;
}

table.display tr.even.gradeA {
    background-color: #eeffee;
}

table.display tr.odd.gradeC {
    background-color: #ddddff;
}

table.display tr.even.gradeC {
    background-color: #eeeeff;
}

table.display tr.odd.gradeX {
    background-color: #ffdddd;
}

table.display tr.even.gradeX {
    background-color: #ffeeee;
}

table.display tr.odd.gradeU {
    background-color: #ddd;
}

table.display tr.even.gradeU {
    background-color: #eee;
}


tr.odd {
}

tr.even {
    background-color: white;
}





/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Misc
 */
.dataTables_scroll {
    clear: both;
}

.dataTables_scrollBody {
    *margin-top: -1px;
}

.top, .bottom {
    background-color: #F5F5F5;
    border: 1px solid #CCCCCC;
}

.top .dataTables_info {
    float: none;
}

.clear {
    clear: both;
}

.dataTables_empty {
    text-align: center;
}

tfoot input {
    margin: 0.5em 0;
    width: 100%;
    color: #444;
}

tfoot input.search_init {
    color: #999;
}

td.group {
    background-color: #d1cfd0;
    border-bottom: 2px solid #A19B9E;
    border-top: 2px solid #A19B9E;
}

td.details {
    background-color: #d1cfd0;
    border: 2px solid #A19B9E;
}


.example_alt_pagination div.dataTables_info {
    width: 40%;
}

.paging_full_numbers {
    width: 400px;
    height: 22px;
    line-height: 22px;
}

.paging_full_numbers span.paginate_button,
    .paging_full_numbers span.paginate_active {
    border: 1px solid #aaa;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    padding: 2px 5px;
    margin: 0 3px;
    cursor: pointer;
    *cursor: hand;
}

.paging_full_numbers span.paginate_button {
    background-color: #ddd;
}

.paging_full_numbers span.paginate_button:hover {
    background-color: #ccc;
}

.paging_full_numbers span.paginate_active {
    background-color: #99B3FF;
}

table.display tr.even.row_selected td {
    background-color: #B0BED9;
}

table.display tr.odd.row_selected td {
    background-color: #9FAFD1;
}




/*
 * Row highlighting example
 */
.ex_highlight #example tbody tr.even:hover, #example tbody tr.even td.highlighted {
    background-color: #ECFFB3;
}

.ex_highlight #example tbody tr.odd:hover, #example tbody tr.odd td.highlighted {
    background-color: #E6FF99;
}

.ex_highlight_row #example tr.even:hover {
    background-color: #ECFFB3;
}

.ex_highlight_row #example tr.even:hover td.sorting_1 {
    background-color: #DDFF75;
}

.ex_highlight_row #example tr.even:hover td.sorting_2 {
    background-color: #E7FF9E;
}

.ex_highlight_row #example tr.even:hover td.sorting_3 {
    background-color: #E2FF89;
}

.ex_highlight_row #example tr.odd:hover {
    background-color: #E6FF99;
}

.ex_highlight_row #example tr.odd:hover td.sorting_1 {
    background-color: #D6FF5C;
}

.ex_highlight_row #example tr.odd:hover td.sorting_2 {
    background-color: #E0FF84;
}

.ex_highlight_row #example tr.odd:hover td.sorting_3 {
    background-color: #DBFF70;
}


/*
 * KeyTable
 */
table.KeyTable td {
    border: 3px solid transparent;
}

table.KeyTable td.focus {
    border: 3px solid #3366FF;
}

table.display tr.gradeA {
    background-color: #eeffee;
}

table.display tr.gradeC {
    background-color: #ddddff;
}

table.display tr.gradeX {
    background-color: #ffdddd;
}

table.display tr.gradeU {
    background-color: #ddd;
}

div.box {
    height: 100px;
    padding: 10px;
    overflow: auto;
    border: 1px solid #8080FF;
    background-color: #E5E5FF;
}



</style>

</head>
<body>

    <div id="header"><div>Logaar</div></div>
    <div id="pageLogin">
    <span><a id="logout" href="/logout">Logout</a></span>
    </div>
    <div id="savereset">
        <span>
            <img src="static/save.png"  rel="#savediag" title="Save" id="saveimg">
        </span>
        <span>
            <img src="static/reset.png" title="Reset" id="reset">
        </span>
    </div>

    <ul class="css-tabs">
        <li><a href="incoming">Incoming</a></li>
        <li><a href="logs">Logs</a></li>
    <!-- <li><a href="hosts">Hosts</a></li>  -->
        <li><a href="rules">Rules</a></li>
        <li><a href="stats">Stats</a></li>
        <li><a href="manage">Manage</a></li>
    </ul>

    <div class="tabpane"><div style="display:block"></div></div>

    <div id="msgpane">
        <div id="gradient"></div>
        <div id="msgslot">
            <table id="msgs">
            </table>
        </div>
    </div>

    <div id="footer">
        <p>Log management</p>
    </div>



<!-- save dialog -->
<div class="modal" id="savediag">
    <h2>Save configuration</h2>
    <p>Please insert a change description</p>
    <form>
        <input />
        <button type="submit"> OK </button>
        <button type="button" class="close"> Cancel </button>
    </form>
    <br />
</div>

<!-- login dialog -->
<div class="modal" id="loginform">
    <h2>Login</h2>
    <p>Please insert your credentials:</p>
    <form>
        <input type="text" name="user" value="username here, pwd below" />
        <input type="password" name="pwd" value="" />
        <br/><br/>
        <button type="submit"> OK </button>
        <button type="button" class="close"> Cancel </button>
    </form>
    <br />
</div>

<script>


$(function() {

    $("ul.css-tabs").tabs("div.tabpane > div", {effect: 'ajax', history: true});


    // Save and reset buttons

    $("div#savereset").hide();


    $("div#savereset img[title]").tooltip({
        tip: '.tooltip',
        effect: 'fade',
        fadeOutSpeed: 100,
        predelay: 800,
        position: "bottom right",
        offset: [15, -30]
    });

    $("div#savereset img").fadeTo(0, 0.6);

    $("div#savereset img").hover(function() {
      $(this).fadeTo("fast", 1);
    }, function() {
      $(this).fadeTo("fast", 0.6);
    });


    $('img#reset').click(function() {
      $.post("reset");
      $('div#savereset').hide();
    });

    // Save form

    var triggers = $("img#saveimg").overlay({
        mask: {
            color: '#ebecff',
            loadSpeed: 200,
            opacity: 0.9
        },
        closeOnClick: false
    });

    $("#savediag form").submit(function(e) {
        var input = $("input", this).val();
        $.post("save",{msg: input}, function(json) {
            triggers.eq(0).overlay().close();
            $('div#savereset').hide();
        },"json");
        return e.preventDefault();
    });

});


</script>
</body>

</html>
% end
