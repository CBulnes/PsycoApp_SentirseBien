/**
 * Zabuto Calendar
 *
 * Dependencies
 * - jQuery (2.0.3)
 * - Twitter Bootstrap (3.0.2)
 */

if (typeof jQuery == 'undefined') {
    throw new Error('jQuery is not loaded');
}

/**
 * Create calendar
 *
 * param options
 * returns {*}
 */
$.fn.zabuto_calendar = function (options) {
    var opts = $.extend({}, $.fn.zabuto_calendar_defaults(), options);
    var languageSettings = $.fn.zabuto_calendar_language(opts.language);
    opts = $.extend({}, opts, languageSettings);

    this.each(function () {
        var $calendarElement = $(this);
        $calendarElement.attr('id', "zabuto_calendar_" + Math.floor(Math.random() * 99999).toString(36));

        $calendarElement.data('initYear', opts.year);
        $calendarElement.data('initMonth', opts.month);
        $calendarElement.data('monthLabels', opts.month_labels);
        $calendarElement.data('weekStartsOn', opts.weekstartson);
        $calendarElement.data('navIcons', opts.nav_icon);
        $calendarElement.data('dowLabels', opts.dow_labels);
        $calendarElement.data('showToday', opts.today);
        $calendarElement.data('showDays', opts.show_days);
        $calendarElement.data('showPrevious', opts.show_previous);
        $calendarElement.data('showNext', opts.show_next);
        $calendarElement.data('cellBorder', opts.cell_border);
        $calendarElement.data('jsonData', opts.data);
        $calendarElement.data('ajaxSettings', opts.ajax);
        $calendarElement.data('legendList', opts.legend);
        $calendarElement.data('actionFunction', opts.action);
        $calendarElement.data('actionNavFunction', opts.action_nav);

        drawCalendar();

        function drawCalendar() {
            var dateInitYear = parseInt($calendarElement.data('initYear'));
            var dateInitMonth = parseInt($calendarElement.data('initMonth')) - 1;
            var dateInitObj = new Date(dateInitYear, dateInitMonth, 1, 0, 0, 0, 0);
            $calendarElement.data('initDate', dateInitObj);

            var tableClassHtml = ($calendarElement.data('cellBorder') === true) ? ' table-bordered' : '';

            $tableObj = $('<table class="table' + tableClassHtml + '"></table>');
            $tableObj = drawTable($calendarElement, $tableObj, dateInitObj.getFullYear(), dateInitObj.getMonth());

            $legendObj = drawLegend($calendarElement);

            var $containerHtml = $('<div class="zabuto_calendar" id="' + $calendarElement.attr('id') + '"></div>');
            $containerHtml.append($tableObj);
            $containerHtml.append($legendObj);

            $calendarElement.append($containerHtml);

            var jsonData = $calendarElement.data('jsonData');
            if (false !== jsonData) {
                checkEvents($calendarElement, dateInitObj.getFullYear(), dateInitObj.getMonth());
            }
        }

        function drawTable($calendarElement, $tableObj, year, month) {
            var dateCurrObj = new Date(year, month, 1, 0, 0, 0, 0);
            $calendarElement.data('currDate', dateCurrObj);

            $tableObj.empty();
            $tableObj = appendMonthHeader($calendarElement, $tableObj, year, month);
            $tableObj = appendDayOfWeekHeader($calendarElement, $tableObj);
            $tableObj = appendDaysOfMonth($calendarElement, $tableObj, year, month);
            checkEvents($calendarElement, year, month);
            return $tableObj;
        }

        function drawLegend($calendarElement) {
            var $legendObj = $('<div class="legend" id="' + $calendarElement.attr('id') + '_legend"></div>');
            var legend = $calendarElement.data('legendList');
            if (typeof (legend) == 'object' && legend.length > 0) {
                $(legend).each(function (index, item) {
                    if (typeof (item) == 'object') {
                        if ('type' in item) {
                            var itemLabel = '';
                            if ('label' in item) {
                                itemLabel = item.label;
                            }

                            switch (item.type) {
                                case 'text':
                                    if (itemLabel !== '') {
                                        var itemBadge = '';
                                        if ('badge' in item) {
                                            if (typeof (item.classname) === 'undefined') {
                                                var badgeClassName = 'badge-event';
                                            } else {
                                                var badgeClassName = item.classname;
                                            }
                                            itemBadge = '<span class="badge ' + badgeClassName + '">' + item.badge + '</span> ';
                                        }
                                        $legendObj.append('<span class="legend-' + item.type + '">' + itemBadge + itemLabel + '</span>');
                                    }
                                    break;
                                case 'block':
                                    if (itemLabel !== '') {
                                        itemLabel = '<span>' + itemLabel + '</span>';
                                    }
                                    if (typeof (item.classname) === 'undefined') {
                                        var listClassName = 'event';
                                    } else {
                                        var listClassName = 'event-styled ' + item.classname;
                                    }
                                    $legendObj.append('<span class="legend-' + item.type + '"><ul class="legend"><li class="' + listClassName + '"></li></u>' + itemLabel + '</span>');
                                    break;
                                case 'list':
                                    if ('list' in item && typeof (item.list) == 'object' && item.list.length > 0) {
                                        var $legendUl = $('<ul class="legend"></u>');
                                        $(item.list).each(function (listIndex, listClassName) {
                                            $legendUl.append('<li class="' + listClassName + '"></li>');
                                        });
                                        $legendObj.append($legendUl);
                                    }
                                    break;
                                case 'spacer':
                                    $legendObj.append('<span class="legend-' + item.type + '"> </span>');
                                    break;

                            }
                        }
                    }
                });
            }

            return $legendObj;
        }

        function appendMonthHeader($calendarElement, $tableObj, year, month) {
            var navIcons = $calendarElement.data('navIcons');
            var $prevMonthNavIcon = $('<span><span class="mdi mdi-chevron-left"></span></span>');
            var $nextMonthNavIcon = $('<span><span class="mdi mdi-chevron-right"></span></span>');
            if (typeof (navIcons) === 'object') {
                if ('prev' in navIcons) {
                    $prevMonthNavIcon.html(navIcons.prev);
                }
                if ('next' in navIcons) {
                    $nextMonthNavIcon.html(navIcons.next);
                }
            }

            var prevIsValid = $calendarElement.data('showPrevious');
            if (typeof (prevIsValid) === 'number' || prevIsValid === false) {
                prevIsValid = checkMonthLimit($calendarElement.data('showPrevious'), true);
            }

            var $prevMonthNav = $('<div class="calendar-month-navigation nav_mes_anterior"></div>');
            $prevMonthNav.attr('id', $calendarElement.attr('id') + '_nav-prev');
            $prevMonthNav.data('navigation', 'prev');
            if (prevIsValid !== false) {

                //recorrer dias y marcar las fechas seleccionadas en el array
                if (fechas != '') {
                    //alert('prev');
                }

                prevMonth = (month - 1);
                prevYear = year;
                if (prevMonth == -1) {
                    prevYear = (prevYear - 1);
                    prevMonth = 11;
                }
                $prevMonthNav.data('to', { year: prevYear, month: (prevMonth + 1) });
                $prevMonthNav.append($prevMonthNavIcon);
                if (typeof ($calendarElement.data('actionNavFunction')) === 'function') {
                    $prevMonthNav.click($calendarElement.data('actionNavFunction'));
                    //alert('2');
                }
                $prevMonthNav.click(function (e) {
                    drawTable($calendarElement, $tableObj, prevYear, prevMonth);

                    //$('.day_click_event').each(function () {
                    //    var fecha_ = $(this).attr('fecha');
                    //    if (fechas.includes(fecha_)) {
                    //        $(this).addClass('selected_date');
                    //    } else {
                    //        console.log('fecha no encontrada en array');
                    //    }
                    //})

                });
            }

            var nextIsValid = $calendarElement.data('showNext');
            if (typeof (nextIsValid) === 'number' || nextIsValid === false) {
                nextIsValid = checkMonthLimit($calendarElement.data('showNext'), false);
            }

            var $nextMonthNav = $('<div class="calendar-month-navigation nav_mes_siguiente"></div>');
            $nextMonthNav.attr('id', $calendarElement.attr('id') + '_nav-next');
            $nextMonthNav.data('navigation', 'next');
            if (nextIsValid !== false) {

                //recorrer dias y marcar las fechas seleccionadas en el array
                if (fechas != '') {
                    //alert('next');
                }

                nextMonth = (month + 1);
                nextYear = year;
                if (nextMonth == 12) {
                    nextYear = (nextYear + 1);
                    nextMonth = 0;
                }
                $nextMonthNav.data('to', { year: nextYear, month: (nextMonth + 1) });
                $nextMonthNav.append($nextMonthNavIcon);
                if (typeof ($calendarElement.data('actionNavFunction')) === 'function') {
                    $nextMonthNav.click($calendarElement.data('actionNavFunction'));
                    //alert('1');
                }
                $nextMonthNav.click(function (e) {
                    drawTable($calendarElement, $tableObj, nextYear, nextMonth);
                    //$('.day_click_event').each(function () {
                    //    var fecha_ = $(this).attr('fecha');
                    //    if (fechas.includes(fecha_)) {
                    //        $(this).addClass('selected_date');
                    //    } else {
                    //        console.log('fecha no encontrada en array');
                    //    }
                    //})
                });
            }

            var monthLabels = $calendarElement.data('monthLabels');

            //var botones_semana_mes = '<div>';
            //botones_semana_mes += '<button type="button" onclick="ver_semana()" class="btn btn-nav-record btn-nav-semana">Semana</button>';
            //botones_semana_mes += '<button type="button" onclick="ver_mes()" class="btn btn-nav-record btn-nav-mes btn-record-sel">Mes</button>';
            //botones_semana_mes += '</div>';

            var $prevMonthCell = $('<th></th>').append($prevMonthNav);
            var $nextMonthCell = $('<th class="row"></th>').append($nextMonthNav);//.append(botones_semana_mes);

            var $currMonthLabel = $('<span>' + monthLabels[month] + ' ' + year + '</span>');
            $currMonthLabel.dblclick(function () {
                var dateInitObj = $calendarElement.data('initDate');
                drawTable($calendarElement, $tableObj, dateInitObj.getFullYear(), dateInitObj.getMonth());
            });

            var $currMonthCell = $('<th colspan="5"></th>');
            //$currMonthCell.append($currMonthLabel);
            $currMonthCell.append(lista_seleccion_meses(month, monthLabels[month], year, $calendarElement, $tableObj, monthLabels));

            var $monthHeaderRow = $('<tr class="calendar-month-header"></tr>');
            $monthHeaderRow.append($prevMonthCell, $currMonthCell, $nextMonthCell);

            $tableObj.append($monthHeaderRow);
            return $tableObj;
        }

        function lista_seleccion_meses(num_mes, nombre_mes, año, $calendarElement, $tableObj, monthLabels) {
            var months_ = '';
            var selected = '';
            for (var i = 0; i < monthLabels.length; i++) {
                if (num_mes == i) {
                    selected = ' selected="selected"';
                } else {
                    selected = '';
                }
                months_ += '<option value="' + i + '"' + selected + '>' + monthLabels[i] + ' ' + año + '</option>';
            }

            var campo_oculto = '<input id="hdnUltMesSeleccionado" value="' + num_mes + '" style="display: none;"/>';
            var $principal_ = $('<select data-año="' + año + '" onchange="cambiar_mes(this)" id="cbo_seleccion_mes">' + months_ + '</select>' + campo_oculto);
            return $principal_;
        }

        function appendDayOfWeekHeader($calendarElement, $tableObj) {
            if ($calendarElement.data('showDays') === true) {
                var weekStartsOn = $calendarElement.data('weekStartsOn');
                var dowLabels = $calendarElement.data('dowLabels');
                if (weekStartsOn === 0) {
                    var dowFull = $.extend([], dowLabels);
                    var sunArray = new Array(dowFull.pop());
                    dowLabels = sunArray.concat(dowFull);
                }

                var $dowHeaderRow = $('<tr class="calendar-dow-header"></tr>');
                $(dowLabels).each(function (index, value) {
                    $dowHeaderRow.append('<th>' + value + '</th>');
                });
                $tableObj.append($dowHeaderRow);
            }
            return $tableObj;
        }

        function appendDaysOfMonth($calendarElement, $tableObj, year, month) {
            var ajaxSettings = $calendarElement.data('ajaxSettings');
            var weeksInMonth = calcWeeksInMonth(year, month);
            var lastDayinMonth = calcLastDayInMonth(year, month);
            var firstDow = calcDayOfWeek(year, month, 1);
            var lastDow = calcDayOfWeek(year, month, lastDayinMonth);
            var currDayOfMonth = 1;

            var dowLabels = $calendarElement.data('dowLabels');

            var weekStartsOn = $calendarElement.data('weekStartsOn');
            if (weekStartsOn === 0) {
                if (lastDow == 6) {
                    weeksInMonth++;
                }
                if (firstDow == 6 && (lastDow == 0 || lastDow == 1 || lastDow == 5)) {
                    weeksInMonth--;
                }
                firstDow++;
                if (firstDow == 7) {
                    firstDow = 0;
                }
            }

            for (var wk = 0; wk < weeksInMonth; wk++) {
                var $dowRow = $('<tr class="calendar-dow"></tr>');
                for (var dow = 0; dow < 7; dow++) {
                    if (dow < firstDow || currDayOfMonth > lastDayinMonth) {
                        $dowRow.append('<td class="dia_inhabilitado"></td>');
                    } else {
                        var dateId = $calendarElement.attr('id') + '_' + dateAsString(year, month, currDayOfMonth);
                        var attr_fecha = dateAsString(year, month, currDayOfMonth);
                        var dayId = dateId + '_day';

                        /* agregar datos de marcación */
                        var dia_inhabilitado_class = validar_dia_inhabilitado(attr_fecha);
                        var dia_feriado_class = verificar_feriado(currDayOfMonth, month, year);

                        var dia_actual_class = '';
                        if (attr_fecha == fecha_actual()) {
                            dia_actual_class = ' current_day_event ';
                        } else {
                            dia_actual_class = '';
                        }

                        var datos_marcacion = contenido_cita(currDayOfMonth, month, year);
                        var $dayElement = $('<div id="' + dayId + '" class="day' + dia_actual_class + dia_inhabilitado_class + dia_feriado_class + '" ><span class="' + validar_feriado(currDayOfMonth, month, year) + '">' + currDayOfMonth + '</span></div>' + datos_marcacion);

                        $dayElement.data('day', currDayOfMonth);

                        if ($calendarElement.data('showToday') === true) {
                            if (isToday(year, month, currDayOfMonth)) {
                                $dayElement.html('<span class="badge badge-today">' + currDayOfMonth + '</span>');
                            }
                        }

                        var $dowElement = $('<td id="' + dateId + '" class="day_click_event' + dia_actual_class + dia_inhabilitado_class + dia_feriado_class + '" fecha="' + attr_fecha + '" onclick="datos_dia(this);"></td>');
                        $dowElement.append($dayElement);

                        $dowElement.data('date', dateAsString(year, month, currDayOfMonth));
                        $dowElement.data('hasEvent', false);

                        if (typeof ($calendarElement.data('actionFunction')) === 'function') {
                            $dowElement.addClass('dow-clickable');
                            $dowElement.click(function () {
                                $calendarElement.data('selectedDate', $(this).data('date'));
                            });
                            $dowElement.click($calendarElement.data('actionFunction'));
                        }

                        $dowRow.append($dowElement);

                        currDayOfMonth++;
                    }
                    if (dow == 6) {
                        firstDow = 0;
                    }
                }

                $tableObj.append($dowRow);
            }
            return $tableObj;
        }

        /* ----- Modal functions ----- */

        function createModal(id, title, body, footer) {
            var $modalHeaderButton = $('<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>');
            var $modalHeaderTitle = $('<h4 class="modal-title" id="' + id + '_modal_title">' + title + '</h4>');

            var $modalHeader = $('<div class="modal-header"></div>');
            $modalHeader.append($modalHeaderButton);
            $modalHeader.append($modalHeaderTitle);

            var $modalBody = $('<div class="modal-body" id="' + id + '_modal_body">' + body + '</div>');

            var $modalFooter = $('<div class="modal-footer" id="' + id + '_modal_footer"></div>');
            if (typeof (footer) !== 'undefined') {
                var $modalFooterAddOn = $('<div>' + footer + '</div>');
                $modalFooter.append($modalFooterAddOn);
            }

            var $modalContent = $('<div class="modal-content"></div>');
            $modalContent.append($modalHeader);
            $modalContent.append($modalBody);
            $modalContent.append($modalFooter);

            var $modalDialog = $('<div class="modal-dialog"></div>');
            $modalDialog.append($modalContent);

            var $modalFade = $('<div class="modal fade" id="' + id + '_modal" tabindex="-1" role="dialog" aria-labelledby="' + id + '_modal_title" aria-hidden="true"></div>');
            $modalFade.append($modalDialog);

            $modalFade.data('dateId', id);
            $modalFade.attr("dateId", id);

            return $modalFade;
        }

        /* ----- Event functions ----- */

        function checkEvents($calendarElement, year, month) {
            var jsonData = $calendarElement.data('jsonData');
            var ajaxSettings = $calendarElement.data('ajaxSettings');

            $calendarElement.data('events', false);

            if (false !== jsonData) {
                return jsonEvents($calendarElement);
            } else if (false !== ajaxSettings) {
                return ajaxEvents($calendarElement, year, month);
            }

            return true;
        }

        function jsonEvents($calendarElement) {
            var jsonData = $calendarElement.data('jsonData');
            $calendarElement.data('events', jsonData);
            drawEvents($calendarElement, 'json');
            return true;
        }

        function ajaxEvents($calendarElement, year, month) {
            var ajaxSettings = $calendarElement.data('ajaxSettings');

            if (typeof (ajaxSettings) != 'object' || typeof (ajaxSettings.url) == 'undefined') {
                alert('Invalid calendar event settings');
                return false;
            }

            var data = { year: year, month: (month + 1) };

            $.ajax({
                type: 'GET',
                url: ajaxSettings.url,
                data: data,
                dataType: 'json'
            }).done(function (response) {
                var events = [];
                $.each(response, function (k, v) {
                    events.push(response[k]);
                });
                $calendarElement.data('events', events);
                drawEvents($calendarElement, 'ajax');
            });

            return true;
        }

        function drawEvents($calendarElement, type) {
            var jsonData = $calendarElement.data('jsonData');
            var ajaxSettings = $calendarElement.data('ajaxSettings');

            var events = $calendarElement.data('events');
            if (events !== false) {
                $(events).each(function (index, value) {
                    var id = $calendarElement.attr('id') + '_' + value.date;
                    var $dowElement = $('#' + id);
                    var $dayElement = $('#' + id + '_day');

                    $dowElement.data('hasEvent', true);

                    if (typeof (value.title) !== 'undefined') {
                        $dowElement.attr('title', value.title);
                    }

                    if (typeof (value.classname) === 'undefined') {
                        $dowElement.addClass('event');
                    } else {
                        $dowElement.addClass('event-styled');
                        $dayElement.addClass(value.classname);
                    }

                    if (typeof (value.badge) !== 'undefined' && value.badge !== false) {
                        var badgeClass = (value.badge === true) ? '' : ' badge-' + value.badge;
                        var dayLabel = $dayElement.data('day');
                        $dayElement.html('<span class="badge badge-event' + badgeClass + '">' + dayLabel + '</span>');
                    }

                    if (typeof (value.body) !== 'undefined') {
                        var modalUse = false;
                        if (type === 'json' && typeof (value.modal) !== 'undefined' && value.modal === true) {
                            modalUse = true;
                        } else if (type === 'ajax' && 'modal' in ajaxSettings && ajaxSettings.modal === true) {
                            modalUse = true;
                        }

                        if (modalUse === true) {
                            $dowElement.addClass('event-clickable');

                            var $modalElement = createModal(id, value.title, value.body, value.footer);
                            $('body').append($modalElement);

                            $('#' + id).click(function () {
                                $('#' + id + '_modal').modal();
                            });
                        }
                    }
                });
            }
        }

        /* ----- Helper functions ----- */

        function isToday(year, month, day) {
            var todayObj = new Date();
            var dateObj = new Date(year, month, day);
            return (dateObj.toDateString() == todayObj.toDateString());
        }

        function dateAsString(year, month, day) {
            d = (day < 10) ? '0' + day : day;
            m = month + 1;
            m = (m < 10) ? '0' + m : m;
            return year + '-' + m + '-' + d;
        }

        function calcDayOfWeek(year, month, day) {
            var dateObj = new Date(year, month, day, 0, 0, 0, 0);
            var dow = dateObj.getDay();
            if (dow == 0) {
                dow = 6;
            } else {
                dow--;
            }
            return dow;
        }

        function calcLastDayInMonth(year, month) {
            var day = 28;
            while (checkValidDate(year, month + 1, day + 1)) {
                day++;
            }
            return day;
        }

        function calcWeeksInMonth(year, month) {
            var daysInMonth = calcLastDayInMonth(year, month);
            var firstDow = calcDayOfWeek(year, month, 1);
            var lastDow = calcDayOfWeek(year, month, daysInMonth);
            var days = daysInMonth;
            var correct = (firstDow - lastDow);
            if (correct > 0) {
                days += correct;
            }
            return Math.ceil(days / 7);
        }

        function checkValidDate(y, m, d) {
            return m > 0 && m < 13 && y > 0 && y < 32768 && d > 0 && d <= (new Date(y, m, 0)).getDate();
        }

        function checkMonthLimit(count, invert) {
            console.log(count);
            console.log(invert);
            if (count === false) {
                count = 0;
            }
            var d1 = $calendarElement.data('currDate');
            var d2 = $calendarElement.data('initDate');

            var months;
            months = (d2.getFullYear() - d1.getFullYear()) * 12;
            months -= d1.getMonth() + 1;
            months += d2.getMonth();

            if (invert === true) {
                if (months < (parseInt(count) - 1)) {
                    return true;
                }
            } else {
                if (months >= (0 - parseInt(count))) {
                    return true;
                }
            }
            return false;
        }
    }); // each()

    return this;
};

/**
 * Default settings
 *
 * returns object
 *   language:          string,
 *   year:              integer,
 *   month:             integer,
 *   show_previous:     boolean|integer,
 *   show_next:         boolean|integer,
 *   cell_border:       boolean,
 *   today:             boolean,
 *   show_days:         boolean,
 *   weekstartson:      integer (0 = Sunday, 1 = Monday),
 *   nav_icon:          object: prev: string, next: string
 *   ajax:              object: url: string, modal: boolean,
 *   legend:            object array, [{type: string, label: string, classname: string}]
 *   action:            function
 *   action_nav:        function
 */
$.fn.zabuto_calendar_defaults = function () {
    var now = new Date();
    var year = now.getFullYear();
    var month = now.getMonth() + 1;
    var settings = {
        language: false,
        year: year,
        month: month,
        show_previous: true,
        show_next: true,
        cell_border: false,
        today: false,
        show_days: true,
        weekstartson: 1,
        nav_icon: false,
        data: false,
        ajax: false,
        legend: false,
        action: false,
        action_nav: false
    };
    return settings;
};

/**
 * Language settings
 *
 * param lang
 * returns {{month_labels: Array, dow_labels: Array}}
 */

$.fn.zabuto_calendar_language = function (lang) {
    if (typeof (lang) == 'undefined' || lang === false) {
        lang = 'en';
    }

    switch (lang.toLowerCase()) {


        case 'en':
            return {
                month_labels: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
                dow_labels: ["Lun", "Mar", "Mier", "Jue", "Vie", "Sáb", "Dom"]
            };
            break;


    }

};

function fnctn_addClass(el, className) {
    if (el.classList)
        el.classList.add(className)
    else if (!hasClass(el, className))
        el.className += " " + className;
}

function fnctn_removeClass(el, className) {
    if (el.classList)
        el.classList.remove(className)
    else if (hasClass(el, className)) {
        var reg = new RegExp('(\\s|^)' + className + '(\\s|$)');
        el.className = el.className.replace(reg, ' ');
    }
}

var fechas = [];
function datos_dia(d) {
    return;
    var id_ = d.getAttribute('id');
    var fecha = id_.slice(-10);

    $('#txtFecha').attr('data-fecha', fecha);
    $('#txtFecha').val(fecha_formato_ddmmyyyy(fecha));

    $('#txtHora').val('');
    $('#cboDoctor').val(-1);

    disponibilidad_doctor();
    $('#mdl_cita').modal('show');
}

function cambiar_mes(e) {
    var año = $(e).attr('data-año');
    var ultimo_mes_seleccionado = $('#hdnUltMesSeleccionado').val();
    var mes_seleccionado = $(e).val();
    var i = 0;

    if (parseInt(mes_seleccionado) < parseInt(ultimo_mes_seleccionado)) {
        i = parseInt(ultimo_mes_seleccionado) - parseInt(mes_seleccionado);
        while (i > 0) {
            $('.nav_mes_anterior').trigger('click');
            i--;
        }
    } else {
        i = parseInt(mes_seleccionado) - parseInt(ultimo_mes_seleccionado);
        while (i > 0) {
            $('.nav_mes_siguiente').trigger('click');
            i--;
        }
    }

    $('#hdnUltMesSeleccionado').val(mes_seleccionado);

    setTimeout(function () {
        Model.cargar_vista_semanal('MES');
    }, 500);
}

function validar_dia_inhabilitado(fecha) {
    var dia = fecha.slice(-2);
    var mes = fecha.substring(0, 7).slice(-2);
    var año = fecha.substring(0, 4);

    var date = new Date(mes + '/' + dia + '/' + año); //mm/dd/yyyy
    var dia = date.toLocaleDateString('es-ES', { weekday: 'long' })

    return (dia == 'sábado' || dia == 'domingo') ? ' dia_inhabilitado' : '';
}

function ver_semana() {
    if ($('#div_semana').not(':visible')) {
        $('#div_semana').show();
        $('#div_mes').hide();
    }
}

function ver_mes() {
    if ($('#div_mes').not(':visible')) {
        $('#div_mes').show();
        $('#div_semana').hide();
    } else {
        var today = new Date();
        var mes_actual = String(today.getMonth()).padStart(2, '0'); //January is 0!

        if (mes_actual == '00') {
            mes_actual = '0';
        }

        $('#txtNumSemanaActual').val(0);
        $('#cbo_seleccion_mes').val(mes_actual).change();
        /*Model.cargar_vista_semanal('MES');*/
    }
}

function verificar_feriado(dia, mes, año) {
    if (mes == 12) {
        mes = 1;
    } else {
        mes++;
    }

    var fecha = año + '-' + formato_2_digitos(mes) + '-' + formato_2_digitos(dia);

    var lista_citas_dia = lista_citas.filter(function (element) {
        return element.fecha_marcacion == fecha;
    });

    if (lista_citas_dia.length > 0 && lista_citas_dia[0].tipo_marcacion == 'FERIADO') {
        return ' dia_feriado ';
    }
    return '';
}

function formato_2_digitos(valor) {
    if (valor.toString().length == 1) {
        return '0' + valor.toString();
    }
    return valor.toString();
}

function fecha_formato_ddmmyyyy(fecha) {
    var dd = fecha.slice(-2);
    var mm = (fecha.slice(-5)).substring(0, 2);
    var yyyy = fecha.substring(0, 4);

    return dd + '/' + mm + '/' + yyyy;
}

function fecha_actual() {
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();

    return yyyy + '-' + mm + '-' + dd;
}

function contenido_cita(dia, mes, año) {
    var html = '';
    var date;
    var dia_nombre;
    var dia_, mes_, año_;

    if (mes == 12) { mes = 1; } else { mes++; }

    var fecha = año + '-' + formato_2_digitos(mes) + '-' + formato_2_digitos(dia);
    var lista_citas_dia = lista_citas.filter(function (element) {
        return element.fecha_cita == fecha;// && element.tipo_marcacion != 'FERIADO';
    });

    if (lista_citas_dia.length == 0) {
        dia_ = fecha.slice(-2);
        mes_ = fecha.substring(0, 7).slice(-2);
        año_ = fecha.substring(0, 4);

        date = new Date(mes_ + '/' + dia_ + '/' + año_); //mm/dd/yyyy
        dia_nombre = date.toLocaleDateString('es-ES', { weekday: 'long' });

        if (dia_nombre == 'sábado' || dia_nombre == 'domingo') {
            html = '-';
        } else {
            html = '';
        }
    } else {
        for (var item of lista_citas_dia) {
            dia_ = item.fecha_cita.slice(-2);
            mes_ = item.fecha_cita.substring(0, 7).slice(-2);
            año_ = item.fecha_cita.substring(0, 4);

            date = new Date(mes_ + '/' + dia_ + '/' + año_); //mm/dd/yyyy
            dia_nombre = date.toLocaleDateString('es-ES', { weekday: 'long' });

            if (dia_nombre == 'sábado' || dia_nombre == 'domingo') {
                html = '-';
            } else {
                if (item.tipo == 'CITA') {
                    var clase_estado = item.estado == 'REGISTRADO' ? 'div_cita_registrada' : 'div_cita_atendida';

                    html += '<div class="div_cita ' + clase_estado + '" data-id-cita="' + item.id_cita + '" data-id-especialista="' + item.id_doctor_asignado + '" data-fecha-cita="' + item.fecha_cita + '" data-hora-cita="' + item.hora_cita + '" data-estado="' + item.estado + '" onclick="ver_cita(this)">';
                    html += 'Especialista: ' + item.doctor_asignado + '<br/>';
                    html += 'Hora: ' + item.hora_cita;
                    html += '</div > ';
                }
                if (item.tipo == 'CUESTIONARIO') {
                    html += '<div class="div_cita" style="background-color: #6fd530; text-align: center;" data-id-cita="' + item.id_cita + '" data-id-cuestionario="' + item.id_doctor_asignado + '" data-estado="' + item.estado + '" onclick="ver_cuestionario(this)">';
                    html += 'Nuevo cuestionario<br/>';// #' + item.id_doctor_asignado + '<br/>';
                    html += '</div > ';
                }
            }
        }
    }

    if (html != '-') {
        html += '<button data-id-cita="0" data-id-especialista="-1" data-fecha-cita="' + fecha + '" data-hora-cita="" data-estado="-" onclick="ver_cita(this)" class="btn btn-primary main_color">+</button>';
    }

    return html;

    

    //if (lista_citas_dia.length == 0) {
    //    html = '';
    //} else {
    //    for (var item of lista_citas_dia) {
    //        if (item.tipo_marcacion == 'INGRESO' || item.tipo_marcacion == 'TARDANZA' || item.tipo_marcacion == 'SALIDA' || item.tipo_marcacion == 'HORAS NO LABORADAS'
    //            || item.tipo_marcacion == 'INGRESO-OMISION' || item.tipo_marcacion == 'SALIDA-OMISION') {
    //            html += '<div class="info_marcacion small_">';
    //            if (item.tipo_marcacion == 'TARDANZA' || item.tipo_marcacion == 'HORAS NO LABORADAS') {
    //                html += '<span class="span_in_out" style="color: red !important;">' + capitalize(item.tipo_marcacion) + '</span><br/><span class="span_hour">' + item.hora_marcacion + '</span>';
    //            } else if (item.tipo_marcacion == 'INGRESO-OMISION') {
    //                html += '<span class="span_in_out" style="background-color: yellow !important; display: table;">Ingreso</span><br/><span class="span_hour">' + item.hora_marcacion + '</span>';
    //            } else if (item.tipo_marcacion == 'SALIDA-OMISION') {
    //                html += '<span class="span_in_out" style="background-color: yellow !important; display: table;">Salida</span><br/><span class="span_hour">' + item.hora_marcacion + '</span>';
    //            }
    //            else {
    //                html += '<span class="span_in_out">' + capitalize(item.tipo_marcacion) + '</span><br/><span class="span_hour">' + item.hora_marcacion + '</span>';
    //            }
    //            html += '</div>';
    //        }

    //        //if (item.tipo_marcacion == 'COMPENSACIÓN') {
    //        //    html += '<div class="info_marcacion"><span class="span_compensacion">' + item.desc1 + '</span></div>';
    //        //}

    //        if (item.tipo_marcacion == 'FALTA (INGRESO)' || item.tipo_marcacion == 'FALTA (SALIDA)') {
    //            html += '<div class="info_marcacion">';
    //            if (item.tipo_marcacion == 'FALTA (INGRESO)') {
    //                html += '<span class="span_falta">Ingreso</span><br/><span class="span_hour" style="color: #FF6877 !important;">FALTA</span>';
    //            } else {
    //                html += '<span class="span_falta">Salida</span><br/><span class="span_hour" style="color: #FF6877 !important;">FALTA</span>';
    //            }
    //            html += '</div>';
    //        }

    //        if (item.tipo_marcacion == 'VACACIONES') {
    //            html += '<div class="info_marcacion"><span class="span_vacaciones">Vacaciones</span></div>';
    //        }

    //        if (item.tipo_marcacion == 'PAPELETA') {
    //            html += '<div class="info_papeleta"><span class="span_papeleta">Papeleta - ' + item.desc1 + '</span><span class="span_papeleta2">Estado:&nbsp;' + item.desc2 + '</span></div>';
    //        }
    //    }
    //}

    //return html;
}

function validar_feriado(dia, mes, año) {
    if (mes == 12) {
        mes = 1;
    } else {
        mes++;
    }

    var fecha = año + '-' + formato_2_digitos(mes) + '-' + formato_2_digitos(dia);

    var lista_citas_dia = lista_citas.filter(function (element) {
        return element.fecha_marcacion == fecha && element.tipo_marcacion == 'FERIADO';
    });

    if (lista_citas_dia.length == 0) {
        return '';
    } else {
        return 'class_feriado';
    }

}