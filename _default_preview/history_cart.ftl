<#-- This file should be replaced by a copy of the Stencils file when
	deploying, to allow customization. Explicitly fail if the collection is not
	the showcase collection. To fix it, copy the file from
	$SEARCH_HOME/share/stencils/libraries/... -->
<#if question.collection.id == 'higher-education-meta' || 
	question.collection.id == 'membership-association-meta' ||
	question.collection.id == 'local-government-meta'  
	>
	<#include "/share/stencils/libraries/base/history_cart.ftl">
<#else>
	<#-- Create a dummy version of a history_cart.ftl macro, as a way to display
		the error message -->
	<#macro LastVisitedLink result>
		<div class="alert alert-danger">
			<p><code>history_cart.ftl</code> is currently directly including the Stencils
			file. This is discouraged as Stencils changes will break the collection
			templates. Please make a copy of <code>history_cart.ftl</code> instead, from the
			Stencils sources (<code>$SEARCH_HOME/share/stencils/libraries/</code>).</p>

			<p>Subsequent template processing will fail until this is fixed.</p>
		</div>
	</#macro>
</#if>

<#-- Macro overrides specific for Funnelback for Local Government -->

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
	Display the click and search history
-->
<#macro SearchHistory>
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
		<section id="search-history" class="search-history module-curator">
			<h2 class="box__title">History</h2>
			<p>
				<a href="#" class="highlight session-history-hide"><span class="fa fa-arrow-left"></span> Back to results</a>
			</p>

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
								<#items as h>
									<div>
										<a href="${h.indexUrl}">${h.title}</a> &middot; <span class="text-info">${prettyTime(h.clickDate)}</span>
										<#if h.query??>
											<span class="text-muted"> for &quot;${(h.query!"")?split("|")[0]?trim}&quot;</span>
										</#if>
									</div>
								</#items>
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
				<article class="module-curator__item module-curator__item ">
					<div class="module-curator__top">
						<h3 class="module-curator__title">
							<span class="fa fa-search"></span> Recent searches
						</h3>
					</div>
					<div class="module-curator__content">
						<#-- Result for search history -->
						<#list session.searchHistory>
							<div class="module-curator__desc session-history-search-results">
								<#items as h>
									<p>
										<a href="?${h.searchParams}">
											${h.originalQuery!} 
											<small>(${h.totalMatching})</small>
										</a> 
										&middot; 
										<span class="text-info">${prettyTime(h.searchDate)}</span>
									</p>
								</#items>
							</div>
						</#list>
						<#-- No results for search history -->
						<p class="module-curator__desc session-history-search-empty">
							Your search history is empty.
						</p>
					</div>
					<#if (session.searchHistory)!?has_content>
						<a class="btn--link session-history-clear-search float-right" href="#" title="Clear click history">										
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


<#macro Configuration>
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
	  	<#local host=httpRequest.getHeader('host')>

		<script type="text/javascript">
			window.addEventListener('DOMContentLoaded', function() {
				new Funnelback.SessionCart({
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
						template: document.getElementById('cart-template-local-government-web').text
					},
					resultItemTrigger: {
						selector: '.enable-cart-on-result',
						labelAdd: '',
						iconAdd: 'far fa-star',
						labelDelete: '',
						iconDelete: 'fas fa-star',
						isLabel: false,
						template: '<span class="text-info float-right">{{>icon-block}} {{>label-block}}</span>',
						position: 'afterbegin'
					},
					/* Trigger to delete an item from the cart */
					cartItemTrigger: {
						selector: ".fb-cart__remove",
						iconDelete: "fas",
						template: '{{>icon-block}} {{>label-block}}',
						position: 'afterbegin',
						isLabel: true,
						labelDelete: "REMOVE FROM SHORTLIST"
					}        
				});
				
				new Funnelback.SessionHistory({
					collection: '${question.collection.id}',
					pageSelector: ['#search-facets-and-results', '#search-cart']
				});
			});

			<#-- ToDo - Figure out how to attach handlebar helpers 
				window.Funnelback.SessionCart.prototype.Handlebars.registerHelper('equal', function(lvalue, rvalue, options) {
					if (arguments.length < 3)
						throw new Error("Handlebars Helper equal needs 2 parameters");
					if( lvalue!=rvalue ) {
						return options.inverse(this);
					} else {
						return options.fn(this);
					}
				});
			-->    
		</script>
	</#if>
</#macro>

<#macro Controls>
	<#if question.collection.configuration.valueAsBoolean("ui.modern.session")>
		
		<section class="clearfix">
			<div class="result-sessions__controls">
				<span class="flb-cart-count"></span>
				 <a class="session-history-toggle">
				 	<span class="fas fa-history"></span>
				 	History
				</a>
			<div>
		</section>
	</#if>
</#macro>

