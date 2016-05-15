function addAField(button_selector, where_to_add_selector, none_text, field_callback) {
    var where_to_add = $(where_to_add_selector)[0];
    var button = $(button_selector);
    var button_text = button.value;
    button.click(function(event) {
        if(!where_to_add["counter"]) {
            where_to_add["counter"] = 0;
        }

        var current_count = where_to_add["counter"] + 1;
        where_to_add["counter"] = current_count;
        where_to_add.appendChild(field_callback(current_count,
                                                where_to_add_selector,
                                                none_text));

        none_text.hide();

        button.value = button_text;
    });
}
