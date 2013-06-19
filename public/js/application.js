$(document).ready(function() {
  var pollFreq = 1000;

  $('.post_tweets').on('submit', function(e){
    console.log('here');
    e.preventDefault();
    $.ajax({
      method: 'post',
      url: '/tweets',
      data: $(this).serialize()
    }).done(function(response){
      console.log(response);
      setTimeout(getJobStatus(response),pollFreq);
    });
  });

  function getJobStatus(jobId){
    $.ajax({
      method: 'get',
      url: '/status/' + jobId + ''
    }).done(function(response){
      $('.job_results').append(response);
      console.log(response);
      if(response === "Nope!")
      {
        setTimeout(getJobStatus(jobId), pollFreq);
      }
    });
  }
});
