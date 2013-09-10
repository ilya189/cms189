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
    <h5><a href="/">Главная</a> / <a href="{site_url('gallery')}">Фотогалерея</a></h5>
</div>
<h2 class="ext">{$current_category.name}</h2>

{if is_array($albums)}
    {foreach $albums as $album}     
    <div class="album-list shadow">
        <h3 class="name"><a href="{site_url('gallery/thumbnails/' . $album.id)}">{$album.name}</a></h3>
		<p class="gall-small">
			{date('d.m.Y', $album.created)} |
            <strong>Фото: {count($album.images)}</strong>
		</p>
		<ul class="products thumbs">
			{$counter = 1}
			{foreach $album.images as $image}
				{if $counter < 5}
				 <li>
				  <a href="{media_url($album.album_url . $image.full_name)}" class="image lightbox" title="{$image.description}" >
					<img src="{media_url($album.thumb_url . $image.full_name)}" alt="{$image.description}" />
				  </a>
				 </li>
				{/if}
			 {$counter++}
			{/foreach}
		</ul>
		<div>
		{$album.description}
		</div>
		<div class="sp"></div>
        <a href="{site_url('gallery/thumbnails/' . $album.id)}">подробнее</a>&nbsp;&rarr;
    </div>
    {/foreach}

{else:}
    Альбомов не найдено.
{/if}
