function detectMob() {
    const toMatch = [
        /Android/i,
        /webOS/i,
        /iPhone/i,
        /iPad/i,
        /iPod/i,
        /BlackBerry/i,
        /Windows Phone/i
    ];

    return toMatch.some((toMatchItem) => {
        return navigator.userAgent.match(toMatchItem);
    });
}

//setTimeout(function () {
//    $("input[name='email']").tooltip({
//        title: "CYKA BLYAAAAAAT, IDI NAHUI!",
//        placement: 'bottom',
//        template: '<div class="tooltip" role="tooltip">' +
//            '<div class="tooltip-arrow"></div>' +
//            '<div class="tooltip-inner"></div>' +
//            '</div>'
//    });

//    //Shows it
//    $("input[name='email']").tooltip('show');
//}, 250);