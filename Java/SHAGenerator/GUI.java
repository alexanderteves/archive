package de.teves.src;

import thinlet.Thinlet;
import thinlet.FrameLauncher;

/**
 * @author Alexander Teves
 */

public class GUI extends Thinlet {
    
    public GUI() throws Exception {
        add(parse("generator.xml"));
    }
    
    public static void main(String[] args) throws Exception {
        new FrameLauncher("SHA Generator", new GUI(), 400, 100);
    }
    
    public void getAndSet(Object inputTextfield, Object outputTextfield) {
        setString(outputTextfield, "text", SHAGenerator.generateHash(getString(inputTextfield, "text")));
    }
    
}
