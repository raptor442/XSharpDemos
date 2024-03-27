// Program.prg
// Created by    : david
// Creation Date : 3/27/2024 11:14:26 AM
// Created for   : 
// WorkStation   : DAVID-LAPTOP


USING System
USING System.Collections.Generic
USING System.Linq
USING System.Text


FUNCTION Start() AS VOID STRICT
    ? "Hello World! Today is ",Today()
    
    UsingArray()
    UsingList()
    UsingListConvertToArray()

    WAIT
    RETURN

FUNCTION UsingArray() AS VOID STRICT    
    LOCAL aDave AS ARRAY
    LOCAL aJoe AS ARRAY
    LOCAL nTemCnt, nTemEle AS DWORD
 
    aJoe := { { "H", "Home" }, { "W", "Work" }, { "M", "Mail"} }
    
    ? "USING ARRAY"
    
    ? aJoe[ 2, 2] // "Work"
 
    // create an array based on just the second dimension of the first
    aDave := {}
    FOR nTemCnt := 1 UPTO alen( aJoe )
        AAdd( aDave, aJoe[ nTemCnt, 2] )   // {Home,Work,Mail}
    NEXT
    ?aDave[2] // "Mail"
 
    // find the element based on the first dimension
    // need the List equivalent of Ascan()
    nTemEle := AScan( aJoe, { |x| x[1] = "M"})  // 2
    ? aJoe[ nTemEle, 2]  // "Mail"
END FUNCTION

FUNCTION UsingList() AS VOID STRICT
    LOCAL aJoe := LIST<LIST<STRING>>{} AS LIST<LIST<STRING>>
    LOCAL aDave AS LIST<STRING>
    LOCAL firstMatchingList AS LIST<STRING>
    
    // Adding sublists directly to initialize aJoe
    aJoe:Add(LIST<STRING>{} {"H", "Home"}) 
    aJoe:Add(LIST<STRING>{} {"W", "Work"})
    aJoe:Add(LIST<STRING>{} {"M", "Mail"})
    
    ? "USING LIST"
    
    // Accessing the second element of the second list (Work)
    ? aJoe[1][1] // Lists are 0-based
    
    // Create a list based on just the second element of each sublist
    aDave := aJoe:Select({x => x[1]}):ToList()
    ? aDave[1] // "Mail", noting lists are 0-based index
    
    // Find the first list where the first element is "M"
    firstMatchingList := aJoe:FirstOrDefault({x => x[0] == "x"})
    IF firstMatchingList != NIL
        ? firstMatchingList[1]  // "Mail"
    ELSE
        ? "<NIL>"
    ENDIF
END FUNCTION

FUNCTION UsingListConvertToArray() AS VOID STRICT
    // Let's say aJoe is initially a List<List<String>>
    LOCAL aJoeList := LIST<LIST<STRING>>{} AS LIST<LIST<STRING>>
    LOCAL aDaveList := LIST<STRING>{} AS LIST<STRING>
    LOCAL aJoe AS ARRAY
    LOCAL aDave AS ARRAY
    LOCAL nTemCnt, nTemEle AS DWORD
 
    // Populating aJoeList
    aJoeList:Add(LIST<STRING>{} {"H", "Home"})
    aJoeList:Add(LIST<STRING>{} {"W", "Work"})
    aJoeList:Add(LIST<STRING>{} {"M", "Mail"})
    
    // Now, convert aJoeList to an array for the rest of the function
    aJoe := aJoeList:Select({x => x:ToArray()}):ToArray()
    
    ? "USING BOTH"
    
    ? aJoe[ 2, 2] // "Work"
 
    // create an array based on just the second dimension of the first
    aDave := {}
    FOR nTemCnt := 1 UPTO alen( aJoe )
        AAdd( aDave, aJoe[ nTemCnt, 2] )   // {Home,Work,Mail}
    NEXT
    ?aDave[2] // "Mail"
 
    // find the element based on the first dimension
    // need the List equivalent of Ascan()
    nTemEle := AScan( aJoe, { |x| x[1] = "M"})  // 2
    ? aJoe[ nTemEle, 2]  // "Mail"
END FUNCTION
