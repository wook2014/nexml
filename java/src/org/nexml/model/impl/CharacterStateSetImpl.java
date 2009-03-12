package org.nexml.model.impl;

import java.util.Set;

import org.nexml.model.CharacterState;
import org.nexml.model.CharacterStateSet;
import org.w3c.dom.Document;

class CharacterStateSetImpl extends
		SetManager<CharacterState> implements CharacterStateSet {

	public CharacterStateSetImpl(Document document) {
		super(document);
		// TODO Auto-generated constructor stub
	}

	private Set<CharacterState> mCharacterStates;

	@Override
	String getTagName() {
		return "states";
	}

	public Set<CharacterState> getCharacterStates() {
		return mCharacterStates;
	}

	public void setCharacterStates(Set<CharacterState> characterStates) {
		mCharacterStates = characterStates;
	}

	public CharacterState createCharacterState() {
		return new CharacterStateImpl(getDocument());
	}

}