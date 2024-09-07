$(".tab-wizard").steps({
    headerTag: "h6"
    , bodyTag: "section"
    , transitionEffect: "fade"
    , titleTemplate: '<span class="step">#index#</span> #title#'
    , labels: {
        finish: "Submit"
    }
    , onFinished: function (event, currentIndex) {
       swal("Form Submitted!", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lorem erat eleifend ex semper, lobortis purus sed.");
            
    }
});

//var old_validation = '.validation-wizard';
var persona_validation = '.formPersona';
var tour_validation = '.formTour';
var hotel_validation = '.formHotel';

// VALIDAR FORM PERSONA
var form1 = $(persona_validation).show();
$(persona_validation).steps({
    headerTag: "h6", bodyTag: "section", transitionEffect: "fade"
    , titleTemplate: '<span class="step">#index#</span> #title#'
    , labels: {
        finish: "Submit"
    }
    , onStepChanging: function (event, currentIndex, newIndex) {
        return currentIndex > newIndex ||
            !(3 === newIndex && Number($("#age-2").val()) < 18)
        && (currentIndex < newIndex && (form1.find(".body:eq(" + newIndex + ") label.error").remove(),
            form1.find(".body:eq(" + newIndex + ") .error").removeClass("error")), form1.validate().settings.ignore = ":disabled,:hidden", form1.valid())
    }
    , onFinishing: function (event, currentIndex) {
        return form1.validate().settings.ignore = ":disabled", form1.valid()
    }
    , onFinished: function (event, currentIndex) {
         swal("Form Submitted!", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lorem erat eleifend ex semper, lobortis purus sed.");
    }
}), $(persona_validation).validate({
    ignore: "input[type=hidden]"
    , errorClass: "text-danger"
    , successClass: "text-success"
    , highlight: function (element, errorClass) {
        $(element).removeClass(errorClass)
    }
    , unhighlight: function (element, errorClass) {
        $(element).removeClass(errorClass)
    }
    , errorPlacement: function (error, element) {
        error.insertAfter(element)
    }
    , rules: {
        email: {
            email: !0
        }
    }
})

// VALIDAR FORM TOUR
var form2 = $(tour_validation).show();
$(tour_validation).steps({
    headerTag: "h6", bodyTag: "section", transitionEffect: "fade"
    , titleTemplate: '<span class="step">#index#</span> #title#'
    , labels: {
        finish: "Submit"
    }
    , onStepChanging: function (event, currentIndex, newIndex) {
        return currentIndex > newIndex ||
            !(3 === newIndex && Number($("#age-2").val()) < 18)
            && (currentIndex < newIndex && (form2.find(".body:eq(" + newIndex + ") label.error").remove(),
                form2.find(".body:eq(" + newIndex + ") .error").removeClass("error")), form2.validate().settings.ignore = ":disabled,:hidden", form2.valid())
    }
    , onFinishing: function (event, currentIndex) {
        return form2.validate().settings.ignore = ":disabled", form2.valid()
    }
    , onFinished: function (event, currentIndex) {
        swal("Form Submitted!", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lorem erat eleifend ex semper, lobortis purus sed.");
    }
}), $(tour_validation).validate({
    ignore: "input[type=hidden]"
    , errorClass: "text-danger"
    , successClass: "text-success"
    , highlight: function (element, errorClass) {
        $(element).removeClass(errorClass)
    }
    , unhighlight: function (element, errorClass) {
        $(element).removeClass(errorClass)
    }
    , errorPlacement: function (error, element) {
        error.insertAfter(element)
    }
    , rules: {
        email: {
            email: !0
        }
    }
})

// VALIDAR FORM HOTEL
var form3 = $(hotel_validation).show();
$(hotel_validation).steps({
    headerTag: "h6", bodyTag: "section", transitionEffect: "fade"
    , titleTemplate: '<span class="step">#index#</span> #title#'
    , labels: {
        finish: "Submit"
    }
    , onStepChanging: function (event, currentIndex, newIndex) {
        return currentIndex > newIndex ||
            !(3 === newIndex && Number($("#age-2").val()) < 18)
            && (currentIndex < newIndex && (form3.find(".body:eq(" + newIndex + ") label.error").remove(),
                form3.find(".body:eq(" + newIndex + ") .error").removeClass("error")), form3.validate().settings.ignore = ":disabled,:hidden", form3.valid())
    }
    , onFinishing: function (event, currentIndex) {
        return form3.validate().settings.ignore = ":disabled", form3.valid()
    }
    , onFinished: function (event, currentIndex) {
        swal("Form Submitted!", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lorem erat eleifend ex semper, lobortis purus sed.");
    }
}), $(hotel_validation).validate({
    ignore: "input[type=hidden]"
    , errorClass: "text-danger"
    , successClass: "text-success"
    , highlight: function (element, errorClass) {
        $(element).removeClass(errorClass)
    }
    , unhighlight: function (element, errorClass) {
        $(element).removeClass(errorClass)
    }
    , errorPlacement: function (error, element) {
        error.insertAfter(element)
    }
    , rules: {
        email: {
            email: !0
        }
    }
})