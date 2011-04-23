<style media="screen" type="text/css">
div.thread {
    margin: 1em;
}
div.thread img {
    float: left;
    margin-right:1em;
}
</style>

<div class="thread">
    % if collector['_enabled']:
        <img src="/static/success.png"></img>
    % else:
        <img src="/static/alert.png"></img>
    % end
    <p>Log collector {{collector['received']}}</p>
</div>

<div class="thread">
    % if parser['_enabled']:
        <img src="/static/success.png"></img>
    % else:
        <img src="/static/alert.png"></img>
    % end
    <p>Log parser {{parser['processed']}} {{parser['failures']}}</p>
</div>


