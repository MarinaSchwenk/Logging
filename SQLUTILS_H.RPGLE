**free
//--------------------------------------------------------------------
// Constants/Procedures used in the SQLUTILS service program.
//
// @since 1/2/18
// @author Marina
//-------------------------------------------------------------------

// deprecated, can be removed after 9/1/18
// dcl-c ROW_NOT_FOUND 'ROW NOT FOUND';

dcl-c SQL_STATE_ROW_NOT_FOUND '02000';

dcl-c SQL_NULL -1;

//-----------------------------------------------------------------
// Return the row count of the SQL you are running.
//
// @since 1/3/18
//----------------------------------------------------------------
dcl-pr getMaxRowCount int( 5 );
    sql varchar( 32000 ) value;
end-pr;


//-----------------------------------------------------------------
// Return the SQL state message from the SQL engine.
//
// @since 1/2/18
//----------------------------------------------------------------
dcl-pr getSQLStateMessage varchar( 1024 );
end-pr;


//-----------------------------------------------------------------
// Return true when you still have rows to loop through.
//
// @since 1/3/18
//----------------------------------------------------------------
dcl-pr hasNext ind;
    maxRowCount int( 5 );
    currentRowCount int( 5 );
end-pr;


//-----------------------------------------------------------------
// Return true if the SQL statement just executed returned an error.
//
// @since 1/2/18
//----------------------------------------------------------------
dcl-pr isSQLError ind;
    sqlState varchar( 5 ) value;
end-pr;


//-----------------------------------------------------------------
// Return true if the null indicator identifies the corresponding
// field is null and should not be used.
//
// @since 2/7/18
//----------------------------------------------------------------
dcl-pr isSQLNull ind;
    nullIndicator int( 5 ) value;
end-pr;


//-----------------------------------------------------------------
// Return true of the SQL statement executed returned a row not found.
// Use this method if you dont want to call multiple procedures to
// return the same value.
//
// @since 1/2/18
//----------------------------------------------------------------
dcl-pr isSQLRowNotFound ind;
    sqlState varchar( 5 ) value;
end-pr;


//-----------------------------------------------------------------
// Return true of the SQL statement just executed was a success.
//
// @since 1/2/18
//----------------------------------------------------------------
dcl-pr isSQLSuccess ind;
    sqlstate varchar( 5 ) value;
end-pr;


//-----------------------------------------------------------------
// Return true of the sql statement just executed returned a warning.
//
// @since 1/2/18
//----------------------------------------------------------------
dcl-pr isSQLWarning ind;
    sqlState varchar( 5 ) value;
end-pr;


