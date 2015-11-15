//side button togglers
var toggler = $('.toggler');
$(toggler).click(function () {
    var toShow = $(this).attr('bh-target');
    $('.dashContent').css({
        'display': 'none'
    });
    $(toShow).css({
        'display': 'block'
    });
});


function showReviewModal(node) {
    console.log(node);
    var bookTitle = node.getAttribute('bh-title');
    $('#reviewTitle').text(bookTitle);
    $('#reviewMaster').fadeIn();
    $('#reviewInput').focus();
}

function hideReviewModal() {
    $('#reviewMaster').fadeOut();
}

$('#smallMenuToggler').click(function(){
    $('#smallMenu').stop().slideToggle();
});


function hideSearchBox() {
    $('#searchBox').slideUp();
}

function toggleSearchBox() {
    $('#searchBox').stop().slideToggle(400, function(){
        $('#searchPut').focus();
    });
}

window.onresize = function() {
    if(window.innerWidth > 960) {
        $('#smallMenu').hide();
    }
}