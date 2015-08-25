example_emails();
handle_checks();

// Obviously we want to delete this when the backend exists.
function example_emails() {
    generate_message(false, 'John Smith', 'Lorem Ipsum', '12-12-12', 'label-warning', 'Important');
    generate_message(false, 'Nida Hayslett', 'Buy This Today', '12-11-12', 'label-success', 'Ad');
    generate_message(true, 'Orpha Skelton', 'Captured African Prince. DO NOT MISS THIS CHANCE', '12-07-12', 'label-danger', '$$$');
    generate_message(true, 'Dancia Ardon', 'Uh-oh, your prescription is expiring', '11-12-12');
    generate_message(true, 'Maxima Schlesinger', 'Best of Groupon: The Deals That Make Us Proud (Unlike Our Nephew, Steve)', '12-12-12');
    generate_message(true, 'Obama', 'Thanks Obama!', '11-12-12');
    generate_message(true, 'Shae Loveall', 'Lorem Ipsum', '10-12-12');
    generate_message(true, 'Rico Heyman', '*don\'t open this email*', '10-12-12');
    generate_message(true, 'Nico Heypan', 'What Can You Afford?', '09-12-12');
    generate_message(true, 'Tantum Guest', 'Lorem Ipsum', '08-12-12', 'label-warning', 'Important');
    generate_message(true, 'Joann Ha', 'What are our customers saying?', '08-10-12');
    generate_message(true, 'John Doe', 'Where to Drink Beer Right Now', '08-03-12');
}

// Used to toggle visible folders when we click more/less
function show_folders() {
    $('.folders#user_folders').show();
    $('.show_more').hide();
}

function hide_folders() {
    $('.folders#user_folders').hide();
    $('.show_more').show();
}
// Generates url-safe string. (Used to generate email click redirect)
function to_slug(Text) {
    return Text
        .toLowerCase()
        .replace(/ /g, '')
        .replace(/[^\w-]+/g, '')
        ;
}

// Select all emails
function select_all() {
    var select_all = !$(document).find('#check_all').hasClass('active');
    $('input:checkbox[id^="check_"]').each(function () {
        var read = $(this).closest('.email').hasClass('read') ? '#F0F0F0' : '#FFFFFF';
        var color = select_all ? '#D6D6D6' : read;
        $(this).prop('checked', select_all);
        $(this).closest('.email').css('background', color);
    });
}

// Redirects the browser using email information. (Ludicrously unsafe)
function email_click_redirect(email) {
    var sender = $(email).find(".sender").text();
    var subject = $(email).find(".subject").text();
    var date = $(email).find(".date").text();
    window.location = "#sender=" + to_slug(sender) +
        "&subject=" + to_slug(subject) +
        "&date=" + to_slug(date);
}

// Handle the checkboxes and stars for each email.
function handle_checks() {
    $('#check_all').click(select_all);
    number_emails = $('.email').size();
    for (var i = 1; i <= number_emails; i++) {
        handle_message(i);
    }
}

// Handle a particular message. (highlighting, clicking, etc)
function handle_message(index) {
    $('.sender_subject_' + index)
        .click(function () {
            email_click_redirect(this);
        });
    $('#message_' + index).hover(
        function () {
            $(this).css('background', '#D6D6D6');
        },
        function () {
            var read = $(this).hasClass('read');
            var checked = $(this).find('#check_' + index).prop('checked');
            if (read) {
                $(this).css('background', checked ? '#D6D6D6' : '#F0F0F0');
            }
            else {
                $(this).css('background', checked ? '#D6D6D6' : '#FFFFFF');
            }
        });
}

/* Appends a message to the listgroup ul.
 * \params
 * Label must be passed as a bootstrap label.
 * Check out the examples for more details how the labels work...
 * read is a boolean corresponding to whether or not the message has been read.
 * The rest of the parameters are rather self explanatory
 */
function generate_message(read, author, subject, date, label, label_message) {
    var email_number = $('.email').size() + 1;
    var read_class = read ? 'email col-md-12 read' : 'email col-md-12 unread';
    $('.mainContent .listgroup')
        .append(
        $('<li>')
            .attr('class', 'line_item')
            .append(
            $('<div>')
                .attr({
                    class: read_class,
                    id: 'message_' + email_number,
                    style: read ? 'background: #F0F0F0;' : 'background: #FFFFFF;'
                })
                .append(
                $('<div>').attr('class', 'col-md-1')
                    .append(
                    $('<input>')
                        .attr({
                            type: 'checkbox',
                            id: 'check_' + email_number
                        }),
                    $('<input>').attr({
                        type: 'checkbox',
                        id: 'message_' + email_number + '_star',
                        class: 'star_message_' + email_number +
                               ' glyphy glyphicon glyphicon-star-empty'
                    })
                ),
                $('<div>')
                    .attr('class', 'sender_subject_' + email_number + ' col-md-11')
                    .append(
                    $('<div>')
                        .attr('class', 'sender col-md-2')
                        .attr('id', 'message_' + email_number + '_sender')
                        .append(author),
                    $('<div>')
                        .attr('class', 'subject col-md-6')
                        .attr('id', 'message_' + email_number + '_subject')
                        .append(
                        $('<span>')
                            .attr('class', 'label ' + label)
                            .append(label_message),
                        ' ' + subject
                    ),
                    $('<time>')
                        .attr('class', 'date col-md-4')
                        .append(date)
                )
            )
        )
    );
}