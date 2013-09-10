<script src="{$THEME}/js/lightBox/js/jquery.lightbox-0.5-min.js"></script>
<link rel="stylesheet" type="text/css" href="{$THEME}/js/lightBox/css/jquery.lightbox-0.5-min.css" />
{literal}
    <script type="text/javascript">
    $(function(){
        $('a.lightbox').lightBox({fixedNavigation:true});
    })
    </script>
{/literal}

<ul class="fotoList">
    {foreach $album.images as $image}
    <li>
		<div>
			<a href="{media_url($album_url . $image.full_name)}" title="" class="image lightbox">
				<img src="{media_url($thumb_url . $image.full_name)}" alt="" />
			</a>
			<div class="fotoText">{$image.description}</div>
		</div>
    </li>
    {/foreach}
</ul>

<div class="sp"></div>