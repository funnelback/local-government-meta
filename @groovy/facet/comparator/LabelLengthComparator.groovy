package facet.comparator;

import groovy.util.logging.Log4j2
import java.util.Comparator;

import com.funnelback.publicui.search.model.transaction.Facet.CategoryValue;

public class LabelLengthComparator implements Comparator<CategoryValue> {
    @Override
    public int compare(CategoryValue o1, CategoryValue o2) {
        return Integer.compare(o1.getLabel().length(), o2.getLabel().length())
    }
}