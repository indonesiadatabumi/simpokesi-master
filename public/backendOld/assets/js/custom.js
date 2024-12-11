$(document).ready(function () {
    /*----------------------------------------
     passward show hide
     ----------------------------------------*/
    $(".show-hide").show();
    $(".show-hide span").addClass("show");

    $(".show-hide span").unbind("click");
    $(".show-hide span").click(function () {
        const input = $(this).parents(".form-input").find(".input-password");
        if ($(this).hasClass("show")) {
            input.attr("type", "text");
            $(this).removeClass("show");
        } else {
            input.attr("type", "password");
            $(this).addClass("show");
        }
    });

    $('form button[type="submit"]').on("click", function () {
        $(".show-hide span").addClass("show");
        $(".show-hide")
            .parent()
            .find(".input-password")
            .attr("type", "password");
    });

    $(".btnLogout").on("click", function (e) {
        e.preventDefault();
        $("#formLogout").submit();
    });

    $("html, body").on("click", ".btnDelete", function (e) {
        e.preventDefault();
        const url = $(this).attr("href");

        swal({
            title: "Apakah Anda yakin?",
            text: "Data yang telah dihapus tidak dapat dikembalikan.",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        }).then((willDelete) => {
            if (willDelete) {
                $("#formDelete").attr("action", url);
                $("#formDelete").submit();
            }
        });
    });

    $(".inputFJH").each(function (key, el) {
        $(el).attr("data-previous", $(el).val());
    });

    $("html, body").on("keyup", ".inputFJH", function (e) {
        let totalFJH = 0;
        $(".inputFJH").each(function (key, el) {
            totalFJH += $(el).val() * 1;
        });

        if (totalFJH > 365) {
            $(this).val($(this).data("previous"));
            swal(
                "Gagal!",
                "Jumlah hari dalam setahun melebihi 365 hari.",
                "error"
            );
        } else {
            $(this).attr("data-previous", $(this).val());
        }
    });

    $(".inputFJH2").each(function (key, el) {
        $(el).attr("data-previous", $(el).val());
    });

    $("html, body").on("keyup", ".inputFJH2", function (e) {
        let totalFJH = 0;
        $(".inputFJH2").each(function (key, el) {
            totalFJH += $(el).val() * 1;
        });

        if (totalFJH > 365) {
            $(this).val($(this).data("previous"));
            swal(
                "Gagal!",
                "Jumlah hari dalam setahun melebihi 365 hari.",
                "error"
            );
        } else {
            $(this).attr("data-previous", $(this).val());
        }
    });

    $("form").on("submit", function () {
        const button = $(this).find('[type="submit"]');

        button.attr("disabled", "disabled");
        button.html('<i class="fa fa-circle-o-notch fa-spin"></i>');
    });

    $('[data-toggle="tooltip"]').tooltip();

    $(".money-format").mask("#,##0", { reverse: true });
    $(".number-format").mask("#,##0.##", { reverse: true });
});
