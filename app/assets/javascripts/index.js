$(document).ready(function(){
    setUpSelect();
    $("#leagues").change(function(){
        league = $(this).val();
        $.ajax({
            url: '/get_teams',
            method: "get",
            data: jQuery.param({league: league}),
            success: function(data){
                $.each(data, function(key, value){
                    for (i = 0; i < value.length; ++i) {
                        let option = $("<option>").val(value[i]['id']).text(value[i]['name']);
                        $("#teams").append(option);
                    }
                })
            },
            error: function () {
                alert("Problem to connect with API, Info is restricted");
                setUpSelect();
            }
        });
    });

    function setUpSelect() {
        let option = $("<option>").val("").text("Choose a team");
        $("#teams").text('');
        $("#teams").append(option);
    }
})
