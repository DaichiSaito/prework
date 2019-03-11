// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require_tree .


$(function() {
    $('.js-getAveragePrice').on('click', function() {

        $('.loading-wrapper').show()
        const hotel_id = $(this).data("hotel_id")

        $.ajax({
            type: 'GET',
            url: '/hotels/' + hotel_id + '/get_average_price',
        }).done(function (result) {
            // 成功処理
            $('#hotel_name').html(result.hotel.hotel_name)
            $('#hotel_price').html(result.average_price)
            $('#hotel_image').attr('src', result.hotel.image_uri)
            $('.loading-wrapper').hide()
            $('#exampleModal').modal('show')
        }).fail(function (result) {
            // 失敗処理
            $('.loading-wrapper').hide()
            console.log("失敗")
        });
    })
})
