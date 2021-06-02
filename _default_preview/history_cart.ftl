<#ftl encoding="utf-8" output_format="HTML" />

<#--
	Display a "Last visited X time ago" link for a result

	@param result Result to display the link for
-->
<#macro LastVisitedLink result>
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session") && session?? && session.getClickHistory(result.indexUrl)??>
		<p class="search-last-visited session-history-link"> 
			<small>
				<span class="far fa-clock"></span>
				Last visited ${prettyTime(session.getClickHistory(result.indexUrl).clickDate)}
			</small>
		</p>
	</#if>
</#macro>

<#--
  Display the shopping cart / shortlist

  Different shortlist templates can be used depending the source collection
  the result is coming from (based on the <code>C</code> metadata).
-->
<#macro Cart>
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
		<#-- 
			ToDo: Add support for card view. The problem at the moment is that the session 
			code is a bit too opinionated in injecting it own html markup which is messing with the 
			cutups.
		-->
		<section class="search-cart">
			<article id="search-cart" class="search-results__list search-results__list--list-view">
			
			</article>
		</section>
	</#if>
</#macro>

<#-- 
	A handlebars template which is used to display all the items in the cart. 
-->
<#macro CartTemplate>
	<!-- history_cart::CartTemplate -->
	<script id="cart-template" type="text/x-handlebars-template">
		<div>
			<button id="flb-cart-box-back" class="btn-link highlight" type="button">
				{{>icon-block icon=backIcon}} {{>label-block label=backLabel}}
			</button>
			<h2 id="flb-cart-box-header" class="text-center d-flex justify-content-center align-items-center">
				{{>icon-block icon=headerIcon}} {{>label-block label=label}}
				<button id="flb-cart-box-clear" class="btn btn-xs btn-danger btn-clear" type="button">
				{{>icon-block icon=clearIcon}} {{>label-block label=clearLabel}}
				</button>
			</h2>
			
			<ul id="flb-cart-box-list" class="list-unstyled"></ul>

		</div>
	</script>
</#macro>

<#--
	Display the click and search history
-->
<#macro SearchHistory>
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
		<section id="search-history" class="search-history module-curator">
			<p>
				<button href="#" class="highlight session-history-hide">
					<span class="fa fa-arrow-left"></span> 
					Back to results
				</button>
			</p>
			<h2 class="box__title">History</h2>

			<#-- Click history -->
			<article class="module-curator__list ">
				<article class="module-curator__item">
					<div class="module-curator__top">
						<h3 class="module-curator__title">
							<span class="fa fa-heart"></span> Recently clicked results
						</h3>
					</div>
					<div class="module-curator__content">
						<#-- Result for click history -->
						<#list session.clickHistory>
							<div class="module-curator__desc session-history-click-results">
								<#-- 
									The sessions code relies on the click history results
									to be wrapped in a <ul>
								--> 
								<ul>
									<#items as h>
										<li class="list-unstyled">
											<p>
												<span class="sr-only">
													Revisit
												</span>
												<a href="${h.indexUrl}">${h.title}</a> &middot; 
												<span class="sr-only">
													which was visited
												</span>									
												<span class="text-info">${prettyTime(h.clickDate)}</span>
												<#if h.query??>							
													<span class="text-muted"> 
														for 
														<span class="sr-only">
															the query
														</span>																								
														&quot;${(h.query!"")?split("|")?first?trim}&quot;
													</span>
												</#if>
											</p>
										</li>
									</#items>
								<ul>
							</div>
						</#list>

						<#-- No results for click history -->
						<p class="module-curator__desc session-history-click-empty">
							Your click history is empty.
						</p>
					</div>
					<#if (session.clickHistory)!?has_content>
						<span class="btn--link session-history-clear-click" title="Clear click history">										
							<span class="fa fa-times"></span> Clear
						</span>
					</#if>
				</article>
				<article class="module-curator__item module-curator__item">
					<div class="module-curator__top">
						<h3 class="module-curator__title">
							<span class="fa fa-search"></span> Recent searches
						</h3>
					</div>
					<div class="module-curator__content">
						<#-- Result for search history -->
						<#list session.searchHistory>
							<div class="module-curator__desc session-history-search-results">
								<#-- 
									The sessions code relies on the search history 
									to be wrapped in a <ul>
								--> 
								<ul>
									<#items as h>
										<li class="list-unstyled">
											<p>
												<a href="?${h.searchParams}" aria-label="View results for '${h.originalQuery!}' which queried ${prettyTime(h.searchDate)}">
													${h.originalQuery!} 
													<small>(${h.totalMatching})</small>
												</a> 
												&middot; 
												<span class="text-info">${prettyTime(h.searchDate)}</span>
											</p>
										</li>
									</#items>
								</ul>
							</div>
						</#list>
						<#-- No results for search history -->
						<p class="module-curator__desc session-history-search-empty">
							Your search history is empty.
						</p>
					</div>
					<#if (session.searchHistory)!?has_content>
						<a class="btn--link session-history-clear-search float-right" href="#" title="Clear recent searches history">										
							<span class="fa fa-times"></span> Clear					
						</a>
					</#if>
				</article>
			</article>

			<#-- Search history -->
			<article class="module-curator__list">

			</article>
		</section>
	</#if>
</#macro>

<#-- 
	The default template used to display items in the cart if a 
	template is not specified via 'stencils.cart.collections' 
	in profile.cfg.
-->
<#macro CartItemTemplate>
	<!-- history_cart.CartItemTemplate -->
	<script id="cart-template-default" type="text/x-handlebars-template">
		<div class="card search-result-default">
		<div class="card-header cart-item-trigger-parent">
			<h4>
			<a href="{{indexUrl}}">{{#truncate 70}}{{title}}{{/truncate}}</a>
			</h4>
			<div class="card-subtitle text-muted">
			<cite>{{#cut "https://"}}{{indexUrl}}{{/cut}}</cite>
			</div>
		</div>
		<div class="card-body">
			<div class="card-text">
			{{#if.listMetadata.image[0]}}
				<img class="img-fluid float-right" alt="{{result.title}}" src="{{metaData.image}}">
			{{/if}}

			{{#if.listMetadata.c[0]}}
				{{#if.listMetadata.date[0]}}<small class="text-muted">{{.listMetadata.date[0]}}:&nbsp;</small>{{/if}}
				{{metaData.c}}
			{{/if}}
			</div>
		</div>
		</div>
	</script>
</#macro>

<#macro Configuration>
	<!-- history_cart.Configurations -->
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
	  	<#local host=httpRequest.getHeader('host')>

		<script type="text/javascript">
			window.addEventListener('DOMContentLoaded', function() {
				new Funnelback.SessionCart({
        			apiBase: '${question.getCurrentProfileConfig().get("stencils.sessions.cart.api_base")!"https://${host}/s/cart.json"}',
					collection: '${question.collection.id}',
					iconPrefix: '',
					cartCount: {
						template: '{{>icon-block}} {{>label-block}} ({{count}})',
						icon: 'fas fa-star',
						label: 'Shortlist',
						isLabel: true
					},
					cart: {
						icon: 'fas fa-star',
						label: 'Saved results',
						backIcon: 'fas fa-arrow-left',
						backLabel: 'Back to results',
						clearIcon: 'fas fa-times',
						clearClasses: "btn btn-xs btn-light",                    
						emptyMessage: '<span id="flb-cart-empty-message">No items in your shortlist</span>',
						pageSelector: ['#search-facets-and-results', '#search-history']
					},
					item: {
						icon: 'fas fa-star',          
						templates: {
							<@CartTemplatesConfig />
						},
						class: ''
					},
					resultItemTrigger: {
						selector: '.enable-cart-on-result',
						labelAdd: '',
						iconAdd: 'far fa-star',
						labelDelete: '',
						iconDelete: 'fas fa-star',
						isLabel: true,
						<#-- 
							Labels are required as they are used as the title of the add/remove buttons
							which is needed for WCAG 2.1. 
						-->
						labelAdd: "Add to shortlist",
						labelDelete: "Remove from shortlist",
						template: '<span class="text-info float-right">{{>icon-block}} <span class="sr-only">{{>label-block}}</span></span>',
						position: 'afterbegin'
					},
					/* Trigger to delete an item from the cart */
					cartItemTrigger: {
						selector: ".fb-cart__remove",
						iconDelete: "fas",
						template: '{{>icon-block}}{{>label-block}}',
						position: 'afterbegin',
						isLabel: true,
						labelDelete: "REMOVE FROM SHORTLIST"
					}        
				});
				
				new Funnelback.SessionHistory({
					searchApiBase: '${question.getCurrentProfileConfig().get("stencils.sessions.history.search.api_base")!"https://${host}/s/search-history.json"}',
					clickApiBase: '${question.getCurrentProfileConfig().get("stencils.sessions.history.click.api_base")!"https://${host}/s/click-history.json"}',
					collection: '${question.collection.id}',
					pageSelector: ['#search-facets-and-results', '#search-cart']
				});
			});
		</script>
	</#if>
</#macro>

<#-- 
	Displays the controls used to toggle the cart and history and 
	query history functionality.
-->
<#macro Controls>
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session")>		
		<!-- history_cart.Controls -->
		<section class="clearfix">
			<div class="result-sessions__controls">
				<span class="flb-cart-count"></span>
				 <a class="session-history-toggle" tabindex="0">
				 	<span class="fas fa-history"></span>
				 	History
				</a>
			<div>
		</section>
	</#if>
</#macro>

<#-- Output the config required to configure the cart templates -->
<#macro CartTemplatesConfig >
	<#-- 
		Output the default template which is used when no cart template 
		is explicitly defined.
	-->
	'default': document.getElementById('cart-template-default').text
	<#if (question.getCurrentProfileConfig().getRawKeys())!?has_content>		
		,
		<#-- 
			Output the custom cart templates config based on the 
			user's configurations 
		-->
		<#list question.getCurrentProfileConfig().getRawKeys()?filter(key -> key?lower_case?starts_with("stencils.template.shortlist.")) as key>
			<#local collection = key?keep_after_last(".")>
			<#local templateName = question.getCurrentProfileConfig().get(key)>
			'${collection}': document.getElementById('cart-template-${templateName}').text
			<#if key_has_next>,</#if>
		</#list> 
	</#if>
</#macro>

<#-- 
	Attempts to find and output all cart templates across all available
	namespaces. It is assummed that cart templates are macros defined with 
	the name <#macro CartTemplate> </#macro>.
-->
<#macro CartTemplatesForResults>
	<!-- history_cart::CartTemplatesForResults -->
	<#list .main as key, namespace >
		<#if (namespace)!?is_hash && (namespace.CartTemplate)!?is_directive && key != "history_cart">
			<@namespace.CartTemplate />
		</#if>
	</#list>
</#macro>