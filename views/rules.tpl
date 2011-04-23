
<img id="help" src="static/help.png" rel="div#help_ovr" title="Help">
<div id="help_ovr">
    <h4>Contextual help: Manage</h4>
    <p>TODO</p>
    <p>Here some nice Lorem ipsum:</p>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
    <br/>
    <p>Press ESC to close this window</p>
</div>


<table id="items">
    <thead>
        <tr>
            % for k in keys:
            <th>{{k}}</th>
            % end
        </tr>
    </thead>
    <tbody>

    </tbody>
</table>

<p><img src="static/new.png" rel="#editing_form" class="new"> New rule</p>

<!-- Item editing or creation form -->
<div id="editing_form">
    <form id="editing_form">
       <fieldset>
          <h3>Host editing</h3>
          <p> Enter values and press the submit button. </p>

          <p>
             <label>hostname *</label>
             <input type="text" name="hostname" pattern="[a-zA-Z0-9_]{2,512}" maxlength="30" />
          </p>
          <p>
             <label>interface *</label>
             <input type="text" name="iface" pattern="[a-zA-Z0-9]{2,32}" maxlength="30" />
          </p>
          <p>
             <label>IP address *</label>
             <input type="text" name="ip_addr" pattern="[0-9.:]{7,}" maxlength="30" />
          </p>
          <p>
             <label>Netmask length *</label>
             <input type="text" name="masklen" pattern="[0-9]{1,2}" maxlength="2" />
          </p>
          <p>
            <label>Local firewall</label>
            <input type="checkbox" name="local_fw" value="local_fw" />
          </p>
          <p>
            <label>Network firewall</label>
            <input type="checkbox" name="network_fw" value="network_fw" />
          </p>
          <p>
            <label>Management interface</label>
            <input type="checkbox" name="mng" value="mng" />
          </p>
          <div id="multisel">
            <p>Routed networks</p>
            <div id="selected">
                <p></p>
            </div>
            <select id="multisel">
                <option></option>
            </select>
          </div>
          <br/>
          <button type="submit">Submit</button>
          <button type="reset">Reset</button>
          <input type="hidden" name="action" value="save" />
          <input type="hidden" name="rid" value="" />
          <input type="hidden" name="token" value="" />
       </fieldset>
    </form>
    <p>Enter and Esc keys are supported.</p>
</div>

<script src="static/jquery.dataTables.min.js" type="text/javascript"></script>



<script>
$(function() {

    table_items = $('table#items').dataTable( {
        "bProcessing": true,
        "bServerSide": true,
        "sAjaxSource": "drules",
        "sPaginationType": "full_numbers",
        "sDom": '<"top"lfp>rt<"bottom"i><"clear">',
    } );

    $('table#items').mousewheel(function(event, delta) {
        if (delta > 0) {
            table_items.fnPageChange( 'previous' );
        } else {
            table_items.fnPageChange( 'next' );
        }
        return false;
    });




    /*
    $("table#items tr td img[title]").tooltip({
        tip: '.tooltip',
        effect: 'fade',
        fadeOutSpeed: 100,
        predelay: 800,
        position: "bottom right",
        offset: [15, 15]
    });

    $("table#items tr td img").fadeTo(0, 0.6);

    $("table#items tr td img").hover(function() {
      $(this).fadeTo("fast", 1);
    }, function() {
      $(this).fadeTo("fast", 0.6);
    });


    $('img.delete').click(function() {
        $.post("hosts", { action: 'delete', rid: this.id},
            function(data){
                $('div.tabpane div').load('/hosts');
            });
    });

    // Populate the routed network combo box based on the existing networks
    function insert_net_names() {
        $.post("net_names",{}, function(json){
            s = $("select#multisel");
            s.html("<option></option>");
            for (i in json.net_names)
                s.append("<option>"+json.net_names[i]+"</option>")
        })
    }

    function set_form_trig() {
        // Remove routed networks on click
        $("div#selected p").click(function() {
            $(this).remove();
        })
    }

    function reset_form() {
        $("form#editing_form input")
        .val('')
        .removeAttr('checked');
        $("form#editing_form input[name=action]").val('save');
        $("div#selected").text('');
    }

    // Open the overlay form to create a new element
    $("img.new[rel]").overlay({
            mask: { loadSpeed: 200, opacity: 0.9 },
            onBeforeLoad: function() {
                reset_form();
                insert_net_names();
            },
            closeOnClick: false
    });

    // If the form is being used to edit an existing item,
    // load the actual values
    $("img.edit[rel]").overlay({
        mask: { loadSpeed: 200, opacity: 0.9 },
        onBeforeLoad: function(event, tabIndex) {
            reset_form();
            rid = this.getTrigger()[0].id;
            $("form#editing_form input[name=rid]").get(0).value = rid;
            $.post("hosts",{'action':'fetch','rid':rid}, function(json){
                $("form#editing_form input[type=text]").each(function(n,f) {
                    f.value = json[f.name];
                });
                $("form#editing_form input[type=checkbox]").each(function(n,f) {
                    f.checked = Boolean(json[f.name]);
                });
                $("form#editing_form input[name=token]").get(0).value = json['token'];
                ds = $("div#selected").text('');
                for (i in json.routed)
                    ds.append('<p>'+json.routed[i]+'</p>');
                set_form_trig();
            }, "json");
            insert_net_names();
        },
        closeOnClick: false
    });


    // Add routed network when the user select it from the combo box
    $("select#multisel").change(function() {
        v = $("select#multisel").val();
        $("select#multisel").val('');
        if (v) $("div#selected").append("<p>"+v+"</p>")
        set_form_trig()
    })



    // Send editing_form field values on submit

    $("form#editing_form").validator().submit(function(e) {
        var form = $(this);
        // client-side validation OK
        if (!e.isDefaultPrevented()) {
        ff = $('form#editing_form').serializeArray();
        // extract the text in the paragraphs in div#selected and squeeze it
        routed = []
        $('div#selected p').each(function(i) {
            routed.push($(this).text())
        })
        // Append routes to the fields list
        ff.push({name: "routed", value: routed});
        $.post("hosts", ff, function(json){
            if (json.ok === true) {
                $("img[rel]").each(function() {
                    $(this).overlay().close();
                });
                $('div.tabpane div').load('/hosts');
            } else {
                form.data("validator").invalidate(json);
            }
        }, "json");
            e.preventDefault();     // prevent default form submission logic
        }
    });
    */

    // Help overlay
    $("img#help[rel]").overlay({ mask: {loadSpeed: 200, opacity: 0.9, }, });
});
</script>

