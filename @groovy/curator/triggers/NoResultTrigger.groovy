import com.funnelback.publicui.search.model.transaction.SearchTransaction;
import com.funnelback.publicui.search.model.transaction.SearchQuestion.SearchQuestionType
import com.funnelback.publicui.search.model.curator.trigger.GroovyTriggerInterface;
import groovy.util.logging.Log4j2

@Log4j2
public class NoResultTrigger implements GroovyTriggerInterface {
  def boolean activatesOn(SearchTransaction searchTransaction, Map<String, Object> properties) {
    if(isMainSearch(searchTransaction) && hasNoResults(searchTransaction)) {
      return true;
    }
    else {
      return false;
    }
  }

  /** 
	 * Returns true if the current transaction is the main search. 
	 * i.e. not content auditor, accessibility auditor orfaceted navigation
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
	public boolean isMainSearch(SearchTransaction searchTransaction) {
		return SearchQuestionType.SEARCH.equals(searchTransaction.question.questionType)
	}

  /** 
	 * Returns true if the current transaction has no matching results 
	 *
	 * @param transaction The funnelback transaction which represents the search
	 **/
  public boolean hasNoResults(SearchTransaction searchTransaction) {
    if(searchTransaction?.response?.resultPacket?.resultsSummary != null && 
      searchTransaction.response.resultPacket.resultsSummary.totalMatching == 0) {
      return true;
    } 
    else {
      return false;
    }
  } 
}