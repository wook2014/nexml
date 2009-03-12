package org.nexml.model;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;

public class TestOTUs {
	@Test
	public void makeOTUs() {
		Document doc = DocumentFactory.createDocument();
		OTUs mammals = doc.createOTUs();
		OTU hippopotamus = mammals.createOTU();
		hippopotamus.setLabel("hippo");

		OTU gorilla = mammals.createOTU();
		gorilla.setLabel("gorilla");
		Assert.assertEquals("gorilla.getLabel() should be \"gorilla\"",
				"gorilla", gorilla.getLabel());

		OTU chimp = mammals.createOTU();
		chimp.setLabel("chimp");
		Assert.assertEquals("chimp.getLabel() should be \"chimp\"", "chimp",
				chimp.getLabel());

		mammals.createOTUSet("primates");

		mammals.addOTUToSet("primates", gorilla);
		mammals.addOTUToSet("primates", chimp);
		Assert.assertEquals("should be 2 primates", 2, mammals.getOTUsFromSet(
				"primates").size());

		Assert.assertEquals("should be 3 otus", 3, mammals.getAllOTUs().size());

		Assert.assertEquals("expected {\"primates\"}", new HashSet<String>(
				Arrays.asList("primates")), mammals.getSetNames());

		mammals.removeOTU(chimp);
		Assert.assertEquals("should be 2 otus", 2, mammals.getAllOTUs().size());

		List<OTU> primates = mammals.getOTUsFromSet("primates");
		Assert.assertEquals("primates.size() should be 1", 1, primates.size());

		mammals.removeOTU(hippopotamus);
		Assert.assertEquals("primates.size() should be 1", 1, primates.size());
	}

}