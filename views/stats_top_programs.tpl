

<style>

    div.hbar {
        border: 1px solid #8888cc;
    }

</style>


<h3>Top programs</h3>
<table id="top_programs">
    <thead>
        <tr>
            <th>Name</th>
            <th>Name</th>
        </tr>
    </thead>

% mi = delta = 0
% if top_programs:
%   mi = min(x[0] for x in top_programs)
%   delta = max(x[0] for x in top_programs) - mi
% if delta:
%     delta = 300.0 / delta
% for n, name in top_programs:
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
