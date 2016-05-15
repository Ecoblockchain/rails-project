var usernames = [];

function getField(identifier, parent_selector, none_text) {
    var parent = $(parent_selector)[0];
    var div_id = "seal-user-" + identifier;
    var name_id = div_id + "-name";
    var button_id = div_id + "-button";
    var terminator_box_id = div_id + "-terminator";
    var verifier_box_id = div_id + "-verifier";
    var checkbox_div = stringToNode("<div></div>");
    var div = stringToNode('<div class="user-add-fields ui-widget" id="' + div_id + '" />');
    var name = stringToNode('<input type="text" class="autocomplete-name" id="' + name_id + '" placeholder="User..." />');
    var remove_button = stringToNode('<button class="user-remove-button" id="' + button_id + '">Remove</button>');
    var terminator_box = makeCheckboxLabel("Terminator?", terminator_box_id, "terminator-checkbox");
    var verifier_box = makeCheckboxLabel("Verifier?", verifier_box_id, "verifier-checkbox");
    div.appendChild(name);
    checkbox_div.appendChild(verifier_box);
    checkbox_div.appendChild(terminator_box);
    div.appendChild(remove_button);
    div.appendChild(checkbox_div);
    remove_button.addEventListener("click", function(event) {
        parent.removeChild(div);
        var div_children_count = $(parent_selector + " > div").length;
        if(div_children_count < 1) {
            none_text.show();
        }
    }, false);

    name.addEventListener("focus", function() {
        update_autocompletes();
    });

    if(!usernames) {
        fetch_usernames(update_autocompletes);
    }

    return div;
}

function update_autocompletes() {
    $(".autocomplete-name").autocomplete({
        source: usernames
    });
};

function makeCheckboxLabel(text, id, klass) {
    var checkbox = '<input type="checkbox" id="' + id + '">';
    var label = '<label for="' + id + '">' + checkbox + text + '</label>';
    return stringToNode(label + checkbox);
}

function getNameFieldData(nameField) {
    var name = $(nameField).find(".autocomplete-name").val();
    var verifier = $(nameField).find(".terminator-checkbox").val();
    var terminator = $(nameField).find(".verifier-checkbox").val();

    return {username: name, verifier: verifier, terminator: terminator};
}

function readAndSendData() {
    var text = $("#seal_text").val();
    var namefields = $("#seal-name-fields .user-add-fields");
    var nameData = [];
    for(var i; i < namefields.length; i++) {
        nameData.push(getNameFieldData(namefields[i]));
    }

    var postObject =  {seal: {text: text,
                              users: nameData}};
    $.post('/seals.json', postObject, function(data) {
        window.location.href = "/seals/" + data.stamp;
    });
}

function fetch_usernames(onSuccess) {
    $.ajax({
        url: '../usernames.json',
        method: 'get',
        dataType: 'json',
        cache: false,
        async: true,
        success: function(data) {
            if(data) {
                usernames = data;
            }

            if(onSuccess) {
                onSuccess();
            }
        },
        error: function() {
            if(!usernames) {
                usernames = [];
            }
        }
    });
}

function ready() {
    fetch_usernames();
    if($("div#seal-name-fields")) {
        addAField("#seal-name-fields-button",
                  "div#seal-name-fields",
                  $("div#seal-name-fields p.none-text"),
                  getField);
        $("input#create-seal").click(readAndSendData);
    }
}

$(document).ready(ready);
$(document).on('page:load', ready);


