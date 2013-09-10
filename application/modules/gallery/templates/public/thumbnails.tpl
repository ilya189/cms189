<script src="{$THEME}/js/lightBox/js/jquery.lightbox-0.5-min.js"></script>
<link rel="stylesheet" type="text/css" href="{$THEME}/js/lightBox/css/jquery.lightbox-0.5-min.css" />
{literal}
    <script type="text/javascript">
    $(function(){
        $('a.lightbox').lightBox({fixedNavigation:true});
    })
    </script>
{/literal}

<div id="titleExt">
    <h5>
        <a href="/">Главная</a> /
        <a href="{site_url('gallery')}">Фотогалерея</a> /
        <a href="{site_url('gallery/category/' . $current_category.id)}">{$current_category.name}</a>
    </h5>
</div>
<h2 class="ext">{$album.name}</h2>

<ul class="products thumbs">
	 {$counter = 1}
    {foreach $album.images as $image}
     <li>
      <a href="{media_url($album_url . $image.full_name)}" title="{$image.description}" class="image lightbox">
		<img src="{media_url($thumb_url . $image.full_name)}" alt="{$image.description}" />
	  </a>
     </li>
     {$counter++}
    {/foreach}
</ul>
<div class="sp"></div>
<div>{$album.description}</div>


