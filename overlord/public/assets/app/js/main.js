$(function()
{
  $('form[name="security"]').submit(function(e)
  {
    e.preventDefault();
    $.post('/security', $(this).serialize(), function(data)
    {
      response = $.parseJSON(data);

      // status
      $('.bomb-status').html(response.bomb_status)

      // display failed attempts to deactivate
      error_text = '';
      if (response.error_count > 0) {
        error_text = 'Failed attempts: ' + response.error_count;
      }
      $('.bomb-errors').html(error_text);

      // destroy bomb
      if (response.bomb_status == 'exploded') {
        $('form').remove();
      }
    });
  });
});