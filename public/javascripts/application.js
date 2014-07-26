// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function toSEOFriendly( from_element, to_element ) {
    to_element.val( from_element.val().toLowerCase().replace(/[^\w ]+/g,'').replace(/ +/g,'-') );
}
