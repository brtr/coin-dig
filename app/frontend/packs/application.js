// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("jquery");
require("./jquery.raty");
require("../stylesheets/application.scss");

import 'bootstrap/dist/css/bootstrap';
import 'bootstrap/dist/js/bootstrap';

window.jQuery = $;
window.$ = $;

let loginAddress = localStorage.getItem("loginAddress");

function replaceChar(origString, firstIdx, lastIdx, replaceChar) {
    let firstPart = origString.substr(0, firstIdx);
    let lastPart = origString.substr(lastIdx);

    let newString = firstPart + replaceChar + lastPart;
    return newString;
}

const checkMetamaskLogin = async function() {
    $("#spinner").removeClass("hide");
    const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
    changeAddress(accounts);
    $("#spinner").addClass("hide");
}

function changeAddress(accounts) {
    if (accounts.length > 0) {
        localStorage.setItem("loginAddress", accounts[0]);
        loginAddress = accounts[0];
        login();
    } else {
        localStorage.removeItem("loginAddress");
        loginAddress = null;
        toggleAddress();
    }
}

const toggleAddress = function() {
    if(loginAddress) {
        $("#login_address").text(replaceChar(loginAddress, 6, -4, "..."));
        $(".loginBtns .navbar-tool").removeClass("hide");
        $(".loginBtns .connect-btn").addClass("hide");
        $(".actions").removeClass("hide");
    } else {
        $(".actions").addClass("hide");
        $(".loginBtns .navbar-tool").addClass("hide");
        $(".loginBtns .connect-btn").removeClass("hide");
    }
}

const login = function() {
    $.ajax({
        url: "/login",
        method: "post",
        data: { address: loginAddress }
    })
}

$(document).on('turbolinks:load', function() {
    'use strict';

    $(function() {
        $('[data-bs-toggle="tooltip"]').tooltip({html: true});

        toggleAddress();

        $("#loginBtn").on("click", function(e){
            e.preventDefault();
            checkMetamaskLogin();
        });

        $("#logoutBtn").on("click", function(e){
            $("#spinner").removeClass("hide");
            e.preventDefault();
            localStorage.removeItem("loginAddress");

            $.ajax({
                url: "/logout",
                method: "post"
            }).done(function(data) {
                if (data.success) {
                    location.reload();
                }
            })
        });

        $(".sidebar-toggle").on("click", function(){
            $("#sidebar").toggleClass("collapsed");
        })

        $(".js-settings-toggle").on("click", function() {
            $(".js-settings").toggleClass("open");
        })

        $("#rating-form").raty({
            path: "/assets/",
            scoreName: "rating"
        })

        $(".review-rating").raty({
            readOnly: true,
            score: function() {
                return $(this).attr("data-score");
            },
            path: "/assets/"
        })

        $(".loadMoreBtn").on("click", function() {
            const page = $("#current_page").val();
            var url = new URL(window.location.href);
            var search_params = url.searchParams;
            search_params.set("page", (parseInt(page) + 1));
            var new_url = window.location.pathname + "?" + search_params.toString();
            $(this).attr("href", new_url);
        })
    })
})
  