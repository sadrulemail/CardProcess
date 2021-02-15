﻿// Code By: Ashik Iqbal
// www.ashik.info

function pageLoad() {
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(jQueryInit);
}
$(document).ready(function () {
    jQueryInit();
});

//for Postback
function pageLoad(sender, args) {
    if (args.get_isPartialLoad()) {
        jQueryInit();    
        if ($('.Load_Note_1000').val() === '') $('.Load_Note_1000').val($('#hidInstruction_Note_1000').val());
        if ($('.Load_Note_500').val() === '') $('.Load_Note_500').val($('#hidInstruction_Note_500').val());

        if ($('.Unload_Note_1000').val() === '') $('.Unload_Note_1000').val($('#hidUnload_Note_1000').val());
        if ($('.Unload_Note_500').val() === '') $('.Unload_Note_500').val($('#hidUnload_Note_500').val());
        CalcAtmLoad();
    }
}

function highlight(value, term) {
    if (term.length > 0)
        return value.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + term.replace(/([\^\$\(\)\[\]\{\}\*\.\+\?\|\\])/gi, "\\$1") + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<span class='highlight'>$1</span>");
    return value;
}

function extractLast(term) {
    return split(term).pop();
}

function split(val) {
    return val.split(/,\s*/);
}
jQuery.browser = {};
(function () {
    jQuery.browser.msie = false;
    jQuery.browser.version = 0;
    if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
        jQuery.browser.msie = true;
        jQuery.browser.version = RegExp.$1;
    }
})();
function addThousandsSeparator(input) {
    var output = input; 
    if (parseFloat(input)) { input = new String(input);
        var parts = input.split(".");
        var last3 = parts[0].split("").reverse().join("").substring(0, 3).split("").reverse().join("");
        var rest = parts[0].split("").reverse().join("").substring(3, 100).split("").reverse().join("");
        rest = rest.split("").reverse().join("").replace(/(\d{2})(?!$)/g, "$1,").split("").reverse().join("");
        parts[0] = rest + ',' + last3;
        output = parts.join("."); 
    }
    return output;
}

function CalcAtmLoad() {
    if ($('.Load_Note_1000').val() === '') $('.Load_Note_1000').val('0');
    if ($('.Load_Note_500').val() === '') $('.Load_Note_500').val('0');    

    var txtLoad_1000 = parseInt($('.Load_Note_1000').val()) * 1000;
    var txtLoad_500 = parseInt($('.Load_Note_500').val()) * 500;

    var Total = txtLoad_1000 + txtLoad_500;
    $('#lblLoad_Note_1000_Amount').text(addThousandsSeparator(txtLoad_1000));
    $('#lblLoad_Note_500_Amount').text(addThousandsSeparator(txtLoad_500));
    $('#lblLoad_TotalAmount').text(addThousandsSeparator(Total));

    if ($('.Unload_Note_1000').val() === '') $('.Unload_Note_1000').val('0');
    if ($('.Unload_Note_500').val() === '') $('.Unload_Note_500').val('0');

    var txtUnload_1000 = parseInt($('.Unload_Note_1000').val()) * 1000;
    var txtUnload_500 = parseInt($('.Unload_Note_500').val()) * 500;

    var UnloadTotal = txtUnload_1000 + txtUnload_500;
    var TotalAmount = Total + UnloadTotal;

    $('#lblUnload_Note_1000_Amount').text(addThousandsSeparator(txtUnload_1000));
    $('#lblUnload_Note_500_Amount').text(addThousandsSeparator(txtUnload_500));
    $('#lblUnload_TotalAmount').text(addThousandsSeparator(UnloadTotal));

    $('#lblTotalAmount').text(addThousandsSeparator(TotalAmount));
}


function jQueryInit() {
    $(document).ready(function() {

        // Prevent the backspace key from navigating back.
        $(document).unbind('keydown').bind('keydown', function(event) {
            var doPrevent = false;
            if (event.keyCode === 8) {
                var d = event.srcElement || event.target;
                if ((d.tagName.toUpperCase() === 'INPUT' && (
                    d.type.toUpperCase() === 'TEXT'
                    || d.type.toUpperCase() === 'PASSWORD')
                    ) || d.tagName.toUpperCase() === 'TEXTAREA') {
                    doPrevent = d.readOnly || d.disabled;
                }
                else {
                    doPrevent = true;
                }
            }
            if (doPrevent) {
                event.preventDefault();
            }
        });
    });


    $('input:text[Watermark]').each(function () {
        $(this).attr('placeholder', $(this).attr('Watermark'));
    });

    $('#MenuDiv').show();

    $('#view-card-details').click(function () {
        //location('Search.aspx?q='+ $('.txt-card-number').val());
        window.open('Search.aspx?q='+ $('.txt-card-number').val(), '_blank');
        //alert($('.txt-card-number').val());
        return false;
    });    

    $('.Date').datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        dateFormat: 'dd/mm/yy',
        showAnim:'show' ,
        yearRange: '-90:+10'

    });

    try {
        $('.empid-pick').autocomplete({
            source: function (request, response) {
                $.getJSON("Search_CS.ashx", {
                    term: extractLast(request.term)
                }, response);
            },
            search: function () {
                // custom minLength
                var term = extractLast(this.value);
                if (term.length < 2) {
                    return false;
                }
            },
            focus: function () {
                // prevent value inserted on focus
                return false;
            },
            autoFocus: true,
            //response:function( event, ui ) { return false; },
            select: function (event, ui) {
                $('.empid-pick').val(ui.item.id);

                return false;
            }
        }).data("ui-autocomplete")._renderItem = function (ul, item) {
            return $("<li>")
              .append("<a title='" + item.id + "'><table><tr><td valign='top'><img src='" + item.img + "' width='50' height='50' /></td><td valign='top'>" + item.result + "</td></tr></table></a>")
              .appendTo(ul);
        };
    } catch (e) { }


    try {
        var SearchKey;
        $('.menu-search').autocomplete({

            source: function (request, response) {
                SearchKey = request.term;
                $.getJSON("Search_Menu.ashx", {
                    term: extractLast(request.term)
                }, response);
            },
            search: function () {
                // custom minLength
                var term = extractLast(this.value);
                if (term.length < 2) {
                    return false;
                }
            },
            focus: function () {
                // prevent value inserted on focus
                return false;
            },
            autoFocus: true,
            //response:function( event, ui ) { return false; },
            select: function (event, ui) {
                //$('.menu-search').val(ui.item.url);
                //location(ui.item.url);
                window.open(ui.item.url, '_top');
                return false;
            }
        }).data("ui-autocomplete")._renderItem = function (ul, item) {
            return $("<li>")
              .append("<a href='" + item.url + "'>" + highlight(item.name, SearchKey) + "</a>")
              .appendTo(ul);
        };
    } catch (e) { }

    $('.Date').attr('placeholder', 'dd/mm/yyyy').attr('autocomplete', 'off');;

    try {
        $('.DateTime').datetimepicker({
            dateFormat: 'dd/mm/yy',
            timeFormat: 'h:mm tt',
            ampm: true
        });
    } catch (E) { }

    try {
        $('.DateTime1').datetimepicker({
            dateFormat: 'dd/mm/yy',
            timeFormat: 'h:mm:ss tt',
            ampm: false
        });
    } catch (E) { }

    try {
        $('.DateTime11').datepicker({
            dateFormat: 'dd/mm/yy',            
        });
    } catch (E) { }

    $('.ReadOnly').attr('readOnly', 'true');
    $("time.timeago").timeago();


    //Datepicker Today Problem Resolve
    $.datepicker._gotoToday = function(id) {
        var target = $(id);
        var inst = this._getInst(target[0]);
        if (this._get(inst, 'gotoCurrent') && inst.currentDay) {
            inst.selectedDay = inst.currentDay;
            inst.drawMonth = inst.selectedMonth = inst.currentMonth;
            inst.drawYear = inst.selectedYear = inst.currentYear;
        }
        else {
            var date = new Date();
            inst.selectedDay = date.getDate();
            inst.drawMonth = inst.selectedMonth = date.getMonth();
            inst.drawYear = inst.selectedYear = date.getFullYear();
            this._setDateDatepicker(target, date);
            this._selectDate(id, this._getDateDatepicker(target));
        }
        this._notifyChange(inst);
        this._adjustDate(target);
        //this.removeClass('ui-priority-secondary');
    }

    $("#ContentPlaceHolder2_txtMsg").on("propertychange keyup paste input", function () {
        $('#ContentPlaceHolder2_lblSMSCount').text(160 - $(this).val().length);
    });

    function hideLoadingDialog() {
        $("#loading").dialog("close");
        $("#loading").dialog("destroy");
    }

    function hideErrorImages() {
        $('.card-image').each(function () {
            if ($(this).attr('src') == 'Images/Error.jpg')
                $(this).addClass('hide');
        });
    }

    $("#tabs").tabs({
        cookie: {
            expires: 7
        },
        collapsible: true,
        fx: { opacity: 'toggle'
        , duration: 'fast'
        }
    });


    $('.txtTotalReq_1000,.txtTotalReq_500').on("propertychange keyup paste input", function () {
        if ($('.txtTotalReq_1000').val() === '') $('.txtTotalReq_1000').val('0');
        if ($('.txtTotalReq_500').val() === '') $('.txtTotalReq_500').val('0');

        var txtTotalReq_1000 = parseInt($('.txtTotalReq_1000').val()) * 1000;
        var txtTotalReq_500 = parseInt($('.txtTotalReq_500').val()) * 500;

        var Total = txtTotalReq_1000 + txtTotalReq_500;
        $('.lblTotalReqAmount').text(addThousandsSeparator(Total));
    });

    

    $('.Load_Note_1000,.Load_Note_500').on("propertychange keyup paste input", function () {
        CalcAtmLoad();
    });

    $('.Unload_Note_1000,.Unload_Note_500').on("propertychange keyup paste input", function () {
        CalcAtmLoad();
    });

    $('.cmd-Attachment-show').click(function () {
        $('.cmd-Attachment-show').hide();
        $('.div-Attachment-Add').show('Slow');
    });
    $('.cmd-Attachment-hide').click(function () {
        $('.div-Attachment-Add').hide('Slow');
        $('.cmd-Attachment-show').show();
    });
    $("#attachmentFileList").sortable({
        handle: ".MoveIcon",
        update: function (event, ui) {
            RefreshAttachments();
        }
    }).disableSelection();

    $('.ReadOnly').attr('readOnly', 'true');

    $('.AttachmentThumbBig').each(function () {
        var imgurl = $(this).attr('LoadImg');
        $(this).attr('src', imgurl);
        $(this).attr('onerror', 'this.src=\'Images/Error.jpg\'');
        $(this).removeAttr('loadimg');
    });

    $('.AttachmentThumb,.AttachmentThumbSelected').each(function () {
        var imgurl = $(this).attr('LoadImg');
        var a = $(this);
        setTimeout(function () {
            a.attr('src', imgurl);
            a.attr('onerror', 'this.src=\'Images/Error.jpg\'');
            a.removeAttr('loadimg');
            hideErrorImages();
        }, 200);
    });   

    $('.loadimg').each(function () {
        var imgurl = $(this).attr('loadimg');
        $(this).attr('src', imgurl);
        $(this).attr('onerror', 'this.src=\'Images/error.png\'');
        $(this).removeAttr('loadimg');
        hideErrorImages();
    });

    $('.hide-blank-detailsview tr').each(function () {
        if ($(this).find('td').hasClass('donothide') == false)
            if($(this).find('td:eq(1)').text().trim() == '')
                $(this).hide();
    });

    //cboServiceType

    var ResultHideforDegree = ["", "2", "3", "4"];
    $("#ContentPlaceHolder2_DetailsViewMaster_cboServiceType").change(function () {       
        if ($.inArray($('#ContentPlaceHolder2_DetailsViewMaster_cboServiceType').val(), ResultHideforDegree) == -1) {            
            $('#ContentPlaceHolder2_DetailsViewMaster_chkSMS').parent().parent().show();
        }
        else {            
            $('#ContentPlaceHolder2_DetailsViewMaster_chkSMS').parent().parent().hide();
        }
    });

    try {
        $('#imgCrop').Jcrop({
            onSelect: storeCoords,
            allowSelect: false,
            setSelect: [400, 400, 0, 0],
            bgOpacity: .3,

            aspectRatio: 1,
            keySupport: false,
            minSize: [50, 50],
            boxHeight: 400
        });
    }
    catch (e) { }

    $('.ms-drop').html('');
    setTimeout(function () {
        $('select').multipleSelect({
            placeholder: 'please select',
            filter: true,
            single: true
        });
    }, 100);

    $('.MainMenu .selected').parent().parent().parent().addClass('selected');
    
}