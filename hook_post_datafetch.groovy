import groovy.util.logging.Log4j2

import com.funnelback.publicui.search.model.transaction.SearchTransaction
import com.funnelback.publicui.search.model.transaction.SearchQuestion.SearchQuestionType

new com.funnelback.stencils.hook.StencilHooks().apply(transaction, binding.hasVariable("hook") ? hook : null)