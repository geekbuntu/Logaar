
<style>

    div.hbar {
        border: 1px solid #8888cc;
    }

</style>


<h3>Top talkers</h3>
<table id="top_talkers">
    <thead>
        <tr>
            <th>Name</th>
            <th>Name</th>
        </tr>
    </thead>
% mi = delta = 0
% if top_talkers:
%   mi = min(x[0] for x in top_talkers)
%   delta = max(x[0] for x in top_talkers) - mi
% if delta:
%     delta = 300.0 / delta
% for n, name in top_talkers:
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
