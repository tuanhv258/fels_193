function showPassword(){
  if(document.getElementById('change').checked) {
    $('.hide-tag').css('display', 'inline');
  } else{
    $('.hide-tag').css('display', 'none');
  }
}

function remove_fields(link) {
  var answer = $(link).parent().parent();
  var answers = document.getElementsByClassName('answer_field');
  console.log(answers.length);
  if(answers.length > 2 ) {
    $(link).parent().find('input[type=hidden]').val('1');
    answers[answer.length - 1].removeAttribute('class');
    $(answer).hide();
  }
  else {
    alert(I18n.t('js.min_answers'));
  }
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g')
  var answers = document.getElementsByClassName('answer_field');
  if(answers.length < 4 ) {
    $('.new_answer').append(content.replace(regexp, new_id));
  }
  else {
    alert(I18n.t('js.max_answers'));
  }
}

$(document).ready(function(){
  $('.radio_answer').change(function() {
    $('.radio_answer').prop('checked', false);
    $(this).prop('checked', true);
  });
});
