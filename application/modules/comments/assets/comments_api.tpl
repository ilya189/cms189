{if $can_comment == 1 AND !$is_logged_in}
    <label>
        <span class="title__icsi-css">{sprintf(lang('login_for_comments'), site_url($modules.auth))}</span>
    </label>
{/if}
<div id="comment__icsi-css">
    {if $comments_arr}
        <div class="title_h2__icsi-css">{lang('s_clients_comment')}</div>
        <ul class="frame-list-comment__icsi-css">
            {foreach $comments_arr as $key => $comment}
                <input type="hidden" id="comment_item_id" name="comment_item_id" value="{$comment['id']}"/>
                <li>
                    <div class="author-data-comment__icsi-css">
                        <span class="author-comment__icsi-css">{$comment.user_name}</span>&nbsp;&nbsp;
                        {if $comment.rate != 0}
                            <div class="star-small d_i-b">
                                <div class="productRate star-small">
                                    <div style="width: {echo (int)$comment.rate *20}%"></div>
                                </div>
                            </div>&nbsp;&nbsp;
                        {/if}
                        <span class="date-comment__icsi-css"> {date('d-m-Y H:i', $comment.date)}</span>
                    </div>
                    <div class="frame-comment__icsi-css">
                        <p>{$comment.text}</p>
                        {if $comment.text_plus != Null}
                            <p>
                                <b>{lang('s_plus')}</b><br>
                                {$comment.text_plus}
                            </p>
                        {/if}
                        {if $comment.text_minus != Null}
                            <p>
                                <b>{lang('s_cons')}</b><br>
                                {$comment.text_minus}
                            </p>
                        {/if}
                    </div>
                    <div class="func-button-comment__icsi-css">
                        {if $can_comment == 0 OR $is_logged_in}
                            <div class="btn__icsi-css f_l__icsi-css">
                                <button type="button" data-rel="cloneAddPaste" data-parid="{$comment['id']}">
                                    <span class="icon-comment__icsi-css">
                                    </span>
                                    {lang('s_comment_answer')}
                                </button>
                            </div>
                        {/if}

                        <div class="f_r__icsi-css">
                            <span class="helper__icsi-css" style="height: 35px;"></span>
                            <span>
                                <span class="btn__icsi-css like__icsi-css">
                                    <button type="button" class="usefullyes" data-comid="{echo $comment.id}">
                                        {lang('s_like')}
                                    </button>
                                    <span id="yesholder{$comment.id}">({echo $comment.like})</span>
                                </span>
                                <span class="divider_l_dl__icsi-css">|</span>
                                <span class="btn__icsi-css dis-like__icsi-css">
                                    <button type="button" class="usefullno" data-comid="{echo $comment.id}">
                                        {lang('s_dislike')}
                                    </button>
                                    <span id="noholder{$comment.id}">({echo $comment.disslike})</span>
                                </span>
                            </span>
                        </div>
                    </div>
                    <ul class="frame-list-comment__icsi-css">
                        {foreach $comment_ch as $com_ch}
                            {if $com_ch.parent == $comment.id}
                                <li>
                                    <div class="author-data-comment__icsi-css">
                                        <span class="author-comment__icsi-css">{$com_ch.user_name}</span>
                                        <span class="date-comment__icsi-css">{date('d-m-Y H:i', $com_ch.date)}</span>
                                    </div>
                                    <div class="frame-comment__icsi-css">
                                        <p>
                                            {$com_ch.text}
                                        </p>
                                    </div>
                                </li>
                            {/if}
                        {/foreach}
                    </ul>
                </li>
            {/foreach}
        </ul>
    {/if}

    {if $can_comment == 0 OR $is_logged_in}

        <div class="frame-comments__icsi-css">
            <div class="title_h2__icsi-css">{lang('s_leave_your_comment')}</div>
            <!-- Start of new comment fild -->
            <div class="form-comment__icsi-css horizontal_form__icsi-css">
                <form method="post">
                    <label>
                        <span class="frame_form_field__icsi-css">
                            <div class="frameLabel__icsi-css error_text" name="error_text"></div>
                        </span>
                    </label>
                    <!-- Start star reiting -->
                    <div class="frameLabel__icsi-css">
                        <span class="title__icsi-css">{lang('s_you_raiting')}</span>
                        <div class="frame_form_field__icsi-css">
                            <div class="star">
                                <div class="productRate star-big clicktemprate">
                                    <div class="for_comment"style="width: 0%"></div>
                                    <input id="ratec" name="ratec" type="hidden" value=""/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End star reiting -->
                    {if !$is_logged_in}
                        <label>
                            <span class="frame_form_field__icsi-css">
                                <div class="msg">
                                    <div class="success">
                                        Коментарий будет отправлен на модерацию
                                    </div>
                                </div>
                            </span>
                        </label>
                        <label>
                            <span class="title__icsi-css">{lang('lang_comment_author')}</span>
                            <span class="frame_form_field__icsi-css">
                                <input type="text" name="comment_author" id="comment_author" value="{get_cookie('comment_author')}"/>
                            </span>
                        </label>
                        <label>
                            <span class="title__icsi-css">{lang('lang_comment_email')}</span>
                            <span class="frame_form_field__icsi-css">
                                <input type="text" name="comment_email" id="comment_email" value="{get_cookie('comment_email')}"/>
                            </span>
                        </label>
                        <!--
                    <label>
                        <span class="title__icsi-css">{lang('lang_comment_site')}</span>
                        <span class="frame_form_field__icsi-css">
                            <input type="text" name="comment_site" id="comment_site" value="{get_cookie('comment_site')}"/>
                        </span>
                    </label>
                        -->
                    {/if}

                    <label>
                        <span class="title__icsi-css">{lang('s_text_comment_one')}</span>
                        <span class="frame_form_field__icsi-css">
                            <textarea name="comment_text" id="comment_text">{$_POST.comment_text}</textarea>
                        </span>
                    </label>
                    <!-- If you want get plus and minus for products - uncoment it
                <label>
                    <span class="title__icsi-css">{lang('s_plus')}</span>
                    <span class="frame_form_field__icsi-css">
                        <textarea name="comment_text_plus" id="comment_text_plus">{$_POST.comment_text}</textarea>
                    </span>
                </label>
                <label>
                    <span class="title__icsi-css">{lang('s_cons')}</span>
                    <span class="frame_form_field__icsi-css">
                        <textarea name="comment_text_minus" id="comment_text_minus" >{$_POST.comment_text}</textarea>
                    </span>
                </label>
                    -->
                    {if $use_captcha}
                        <label>
                            <span class="title__icsi-css">{lang('lang_captcha')}</span>
                            {$cap_image}
                            <span class="frame_form_field__icsi-css">
                                <input type="text" name="captcha" id="captcha"/>
                            </span>
                        </label>
                    {/if}

                    <div class="frameLabel__icsi-css">
                        <span class="title__icsi-css">&nbsp;</span>
                        <span class="frame_form_field__icsi-css">
                            <input type="submit" value="{lang('s_leave_comment')}" class="btn__icsi-css" onclick="post(this)"/>
                        </span>
                    </div>
                </form>
            </div>
            <!-- End of new comment fild -->
        {/if}
    </div>

    <div class="frame-drop-comment__icsi-css" data-rel="whoCloneAddPaste">
        <div class="form-comment__icsi-css horizontal_form__icsi-css">
            <form>
                <label>
                    <span class="frame_form_field__icsi-css">
                        <div class="frameLabel__icsi-css error_text" name="error_text"></div>
                    </span>
                </label>

                {if !$is_logged_in}
                    <label>
                        <span class="title__icsi-css">{lang('lang_comment_author')}</span>
                        <span class="frame_form_field__icsi-css">
                            <input type="text" name="comment_author" id="comment_author" value="{get_cookie('comment_author')}"/>
                        </span>
                    </label>
                    <label>
                        <span class="title__icsi-css">{lang('lang_comment_email')} </span>
                        <span class="frame_form_field__icsi-css">
                            <input type="text" name="comment_email" id="comment_email" value="{get_cookie('comment_email')}"/>
                        </span>
                    </label>

                    <label>
                        <span class="frame_form_field__icsi-css">
                            <div class="msg">
                                <div class="success">
                                    Коментарий будет отправлен на модерацию
                                </div>
                            </div>
                        </span>
                    </label>
                {/if}
                <label>
                    <span class="title__icsi-css">Комментарий</span>
                    <span class="frame_form_field__icsi-css">
                        <textarea id="comment_text" name="comment_text"></textarea>
                    </span>
                </label>
                <div class="frameLabel__icsi-css">
                    <span class="title__icsi-css">&nbsp;</span>
                    <span class="frame_form_field__icsi-css">
                        <input type="hidden" id="parent" name="comment_parent" value="">
                        <input type="submit" value="{lang('s_leave_comment')}" class="btn__icsi-css" onclick="post(this)"/>
                    </span>
                </div>
            </form>
        </div>
    </div>

    <script>
        {literal}
            $('form').submit(function(e) {
                e.preventDefault();
            });

            (function($) {
                var methods = {
                    init: function(options) {
                        var settings = $.extend({
                            pasteAfter: $(this),
                            pasteWhat: $('[data-rel="whoCloneAddPaste"]'),
                            evPaste: 'click',
                            effectIn: 'fadeIn',
                            effectOff: 'fadeOut',
                            wherePasteAdd: this,
                            whatPasteAdd: '<input type="hidden">',
                            duration: 300,
                            before: function(el) {
                                return;
                            },
                            after: function(el, elInserted) {
                                return;
                            }
                        }, options);
                        var $this = $(this);

                        pasteAfter = settings.pasteAfter;
                        pasteWhat = settings.pasteWhat;
                        evPaste = settings.evPaste;
                        effectIn = settings.effectIn;
                        effectOff = settings.effectOff;
                        duration = settings.duration;
                        wherePasteAdd = settings.wherePasteAdd;
                        whatPasteAdd = settings.whatPasteAdd;
                        before = settings.before;
                        after = settings.after;

                        pasteAfter = pasteAfter.split('.'),
                                $this.on(evPaste, function() {
                            methods.evClick($(this))
                        })
                    },
                    evClick: function($this) {
                        var pasteAfter2 = $this;
                        $.each(pasteAfter, function(i, v) {
                            pasteAfter2 = pasteAfter2[v]();
                        })

                        var insertedEl = pasteAfter2.next(),
                                pasteAfterEL = pasteAfter2;

                        before($this);

                        if (!pasteAfterEL.hasClass('already')) {
                            pasteAfterEL.after(pasteWhat.clone().hide().find(wherePasteAdd).prepend(whatPasteAdd).end()).addClass('already');
                            pasteAfterEL.next()[effectIn](duration, function() {
                                if (ltie7)
                                    ieInput();
                            })
                            after($this, pasteAfterEL.next());
                        }
                        else if (insertedEl.is(':visible'))
                            insertedEl[effectOff](duration);
                        else if (!insertedEl.is(':visible'))
                            insertedEl[effectIn](duration);

                    }
                };
                $.fn.cloneAddPaste = function(method) {
                    if (methods[method]) {
                        return methods[ method ].apply(this, Array.prototype.slice.call(arguments, 1));
                    } else if (typeof method === 'object' || !method) {
                        return methods.init.apply(this, arguments);
                    } else {
                        $.error('Method ' + method + ' does not exist on jQuery.cloneaddpaste');
                    }
                };
            })(jQuery);

            $(document).ready(function() {
                $('[data-rel="cloneAddPaste"]').cloneAddPaste({
                    pasteAfter: 'parent.parent',
                    pasteWhat: $('[data-rel="whoCloneAddPaste"]'),
                    evPaste: 'click',
                    effectIn: 'slideDown',
                    effectOff: 'slideUp',
                    duration: 300,
                    wherePasteAdd: 'form',
                    whatPasteAdd: '',
                    before: function(el) {
                        el.parent().toggleClass('active');
                    },
                    after: function(el, elInserted) {
                        $(elInserted).find('input[name=comment_parent]').val(el.data('parid'));
                        $('form').submit(function() {
                            return false;
                        });
                    }
                });
            })

            $('span.clicktemprate').on('click', function() {
                var rate = $(this).attr('title');
                var ratec;
                if (rate == 1)
                    ratec = "onestar";
                if (rate == 2)
                    ratec = "twostar";
                if (rate == 3)
                    ratec = "threestar";
                if (rate == 4)
                    ratec = "fourstar";
                if (rate == 5)
                    ratec = "fivestar";
                $('#comment_block').removeClass().addClass('rating ' + ratec + ' star_rait');
                $('#ratec').attr('value', rate);
            });

            $('.usefullyes').on('click', function() {
                var comid = $(this).attr('data-comid');
                $.ajax({
                    type: "POST",
                    data: "comid=" + comid,
                    dataType: "json",
                    url: '/comments/commentsapi/setyes',
                    success: function(obj) {
                        if (obj !== null)
                            $('#yesholder' + comid).html("(" + obj.y_count + ")");
                    }
                });
            });

            $('.usefullno').on('click', function() {
                var comid = $(this).attr('data-comid');
                $.ajax({
                    type: "POST",
                    data: "comid=" + comid,
                    dataType: "json",
                    url: '/comments/commentsapi/setno',
                    success: function(obj) {
                        if (obj !== null)
                            $('#noholder' + comid).html("(" + obj.n_count + ")");
                    }
                });
            });

            $(".star-big").starRating({
                width: 26,
                afterClick: function(el, value) {
                    if (el.hasClass("clicktemprate")) {
                        $('.productRate > div.for_comment').css("width", value * 20 + '%');
                        $('#ratec').attr('value', value);
                    }
                }
            });
        {/literal}
    </script>
</div>