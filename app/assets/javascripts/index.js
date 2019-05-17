$(document).ready(function(){
    $("#teams").append('<option selected id="default">Choose a team</option>');
    $("#leagues").change(function(){
        league = $(this).val();
        $.ajax({
            url: '/get_teams',
            headers: {},
            method: "get",
            data: jQuery.param({league: league}),
            success: function(data){
                $("#teams").text('');
                $("#teams").append('<option selected id="default">Choose a team</option>');
                $.each(data, function(key, value){
                    for (i = 0; i < value.length; ++i) {
                        let option = $("<option>").val(value[i]['id']).text(value[i]['name']);
                        $("#teams").append(option);
                    }
                })
            },
            error: function () {
                alert("Problem to connect with API, Info is restricted");
                $("#teams").text('');
                $("#teams").append('<option selected id="default">Choose a team</option>');
            }
        });
    });
})
