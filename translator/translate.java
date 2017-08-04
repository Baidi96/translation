package translator;

import java.io.*;

//multiple and, ssep (and not finished, tobool may reuse)
//distinct done
//tobool = not floor done
//() after ref done done
public class translate {
	public static void main(String[] args) throws IOException{
		int index = 3;
		for(index = 4; index<10;index++){
		String prelude_file = "/Users/baidi/Desktop/intern_note/translator/bolognesa.match";
		String sl_file = "/Users/baidi/Desktop/smtcomp14-sl-master/bench/sll0a_entl/bolognesa-10-e0"+index+".tptp.smt2";
		makeML(prelude_file,sl_file, index);
		}
	}
	static void makeML(String prelude, String sl, int index) throws IOException{
		BufferedWriter writer = null;
		 final File Result = new File("/Users/baidi/Desktop/matching-logic-prover/ml2fol_translation/translate/bolognesa-10-e0"+index+".tptp.match");
		 writer = new BufferedWriter(new FileWriter(Result));
		 File file = new File(prelude);
	        BufferedReader reader = null;
	            reader = new BufferedReader(new FileReader(file));
	            String tempString = null;
	            while ((tempString = reader.readLine()) != null) {
	            	writer.write(tempString+"\n");
	            }
	            reader.close();
	            reader = null;
	            File sl_file = new File(sl);
	            reader = new BufferedReader(new FileReader(sl_file));
	            tempString = null;
	            boolean flag = false; //assertion start
	            boolean intobool = false;
	            int bool_int = 0;
	            boolean inssep = false;
	            boolean preaddssep = false;
	            int addssep = 0;
	            int ssep_int = 0;
	            boolean inand = false;
            	char l = '(';
            	char r = ')';
	            while ((tempString = reader.readLine()) != null) {
	            	//System.out.println(tempString+"\n");
		            boolean haswrite = false;
		            /*(tobool ...) => (not (floor ...))*/
		            if(intobool){
		            	char[] chars = tempString.toCharArray();
		            	int i = 0;
		            	for(i = 0; i < chars.length; i++){
		            	    if(l == chars[i])
		            	        bool_int++;
		            	    else if(r == chars[i]){
		            	    	bool_int--;
		            	    	if(bool_int ==0)
		            	    		break;
		            	    }
		            	}
		            	if(i!=chars.length && bool_int==0){
		            		String news = tempString.substring(0,i+1)+")"+tempString.substring(i+1,chars.length);
		            		tempString = news;
		            		intobool = false;
		            	}           	
		            }
		            /*(ssep ... ... ...) => (ssep ... (ssep ... ...))*/
		            if(inssep){
		            	if( preaddssep){
			            	if(tempString.indexOf("emp")==-1){
			            		String news = "	(ssep "+ tempString;
	    	    				tempString = news;
	    	    				addssep++;
	    	    				ssep_int--;
			            	}
			            	preaddssep = false;
			            }
		            	char[] chars = tempString.toCharArray();
		            	int i = 0;
		            	for(i = 0; i < chars.length; i++){
		            	    if(l == chars[i])
		            	        ssep_int++;
		            	    else if(r == chars[i]){
		            	    	ssep_int--;
		            	    	if(ssep_int ==0){
		            	    		preaddssep = true;
				            		break;
		            	    	}
		            	    	else if(ssep_int == -1)
		            	    		break;
		            	    }
		            	}
		            	if(ssep_int==-1){
		            		String paren = "";
		            		while(addssep!=0){
		            			paren+=")";
		            			addssep--;
		            		}
		            		String news = tempString.substring(0,i+1)+paren+tempString.substring(i+1,chars.length);
		            		tempString = news;
		            		ssep_int = 0;
		            		inssep = false;
		            	}
		            }
		            if(tempString.indexOf("ssep")!=-1 && flag)
		            	inssep = true;
	            	if(tempString.indexOf("assert")!=-1){
	            		flag = true;
	            		writer.write(tempString+"\n");
	            		haswrite = true;
	            	}
	            	if(tempString.indexOf("tobool")!=-1 && flag){
	            		bool_int--;//not count paren in "(tobool"
	            		char[] chars = tempString.toCharArray();
	            		int i = 0;
		            	for(i = 0; i < chars.length; i++){
		            	    if(l == chars[i])
		            	        bool_int++;
		            	    else if(r == chars[i]){
		            	    	bool_int--;
		            	    	if(bool_int ==0)
		            	    		break;
		            	    }
		            	}
		            	if(i!=chars.length && bool_int==0){
		            		String news2 = tempString.substring(0,i+1)+")"+tempString.substring(i+1,chars.length);
		            		tempString = news2;
		            		intobool = false;
		            	}
		            	String news = tempString.replace("tobool", "not (floor ");
	            		writer.write(news+"\n");
	            		haswrite = true;
	            		intobool = true;
	            	}
	            	/*(ref ... ...) => (ref (... ...))*/
	            	if(tempString.indexOf("ref")!=-1 && flag){
	            		int pos = tempString.indexOf("ref");
	            		int length = tempString.length();
	            		int lparen = tempString.substring(pos+4, length).indexOf(")");
	            		//System.out.println(lparen+" "+pos+"\n");
	            		writer.write(tempString.substring(0, pos+4)+"("+tempString.substring(pos+4, pos+4+lparen)+")"+tempString.substring(pos+4+lparen, length)+"\n");
	            		haswrite = true;
	            	}
	            	/*(distinct ... ...) => (not (= ... ...))*/
	            	if(tempString.indexOf("distinct")!=-1 && flag){
	            		String news = tempString.replace("distinct", "not (=");
	            		int pos = news.substring(news.indexOf("not (="),news.length()).indexOf(")");
	            		writer.write(news.substring(0,pos+news.indexOf("not (="))+")"+news.substring(pos+news.indexOf("not (="),news.length()));
	            		haswrite = true;
	            	}
	            	if(flag && !haswrite && tempString.indexOf("check-sat")==-1)
	            		writer.write(tempString+"\n");
	            }
	            writer.close();

	}
}
