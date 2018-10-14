**free
ctl-opt nomain bnddir( 'TEXTUTILS' : 'EVBLOG' );
//--------------------------------------------------------------------------------------
// SQLUTILS
// SQL utility service program that has a series of procedures commonly used in embedded sql.
//
// @since 1/2/18
// @author Marina Schwenk
//--------------------------------------------------------------------------------------

 /copy sqlutils_h
 /copy textutil_h
 /copy evblog_h


//-----------------------------------------------------------------
// return the row count of the sql you are running.
//
// @since 1/3/18
//----------------------------------------------------------------
dcl-proc getMaxRowCount export;

   dcl-pi getMaxRowCount int( 5 );
       sql varchar( 32000 ) value;
   end-pi;

   dcl-s count int( 5 ) inz( 0 );
   dcl-s newSql varchar( 32000 ) inz('');
   dcl-s sqlerrorText varchar( 1024 );

   newSql = 'with temp as ( ' + sql + ' ) select count(*) as count from temp';

   exec sql declare  getcount cursor for getrows;

   if ( not isSQLError( sqlstt ) );

       exec sql prepare getrows from :newsql;

   elseif ( not isSQLError( sqlstt ) );

       exec sql open getcount;

   elseif ( not isSQLError( sqlstt ) );

       exec sql fetch next from getcount into :count;

   endIf;

   exec sql close getcount;

   return count;

end-proc;

//-----------------------------------------------------------------
// return the sql state message from the sql engine.
//
// @since 1/2/18
//----------------------------------------------------------------
dcl-proc getSQLStateMessage export;

    dcl-pi getSQLStateMessage varchar( 1024 );
    end-pi;

    dcl-s sqlErrorText varchar( 1024 );

    exec sql
        get diagnostics condition 1 :sqlerrortext = message_text;

   return sqlErrorText;

end-proc;

//-----------------------------------------------------------------
// return true when you still have rows to loop through.
//
// @since 1/3/18
//----------------------------------------------------------------
dcl-proc hasNext export;

    dcl-pi hasNext ind;
        maxRowCount int( 5 );
        currentRowCount int( 5 );
    end-pi;

    if ( maxRowCount >= currentRowCount );
        return *on;
    endIf;

    return *off;

end-proc;

//-----------------------------------------------------------------
// return true if the sql statement just executed returned with an error.
//
// @since 1/2/18
//----------------------------------------------------------------
dcl-proc isSQLError export;

    dcl-pi isSQLError ind;
       sqlState varchar( 5 ) value;
    end-pi;

    dcl-s beginningSqlState char( 2 );

    beginningSqlState = %subst( sqlState: 1: 2);

    if ( beginningSqlState <> '' and  beginningSqlState <> '00' and beginningSqlState <> '01' );
       return *on;
    endIf;

    return *off;

end-proc;

//-----------------------------------------------------------------
// Return true if the null indicator identifies the corresponding
// field is null and should not be used.
//
// @since 1/2/18
//----------------------------------------------------------------
dcl-proc isSQLNull export;

    dcl-pi *n ind;
       nullIndicator int( 5 ) value;
    end-pi;

    return ( nullIndicator = SQL_NULL );

end-proc;

//-----------------------------------------------------------------
// return true of the sql statement executed returned a row not found.
// use this method if you dont want to call multiple procedures to
// return the same value.
//
// @since 1/2/18
//----------------------------------------------------------------
dcl-proc isSQLRowNotFound export;

    dcl-pi isSQLRowNotFound ind;
       sqlState varchar( 5 ) value;
    end-pi;

    return ( sqlState = SQL_STATE_ROW_NOT_FOUND );

end-proc;

//-----------------------------------------------------------------
// return true of the sql statement just executed was a success.
//
// @since 1/2/18
//----------------------------------------------------------------
dcl-proc isSQLSuccess export;

    dcl-pi isSQLSuccess ind;
       sqlState varchar( 5 ) value;
    end-pi;

    if ( %subst( sqlState : 1 : 2 ) = '00' );
       return *on;
    endIf;

    return *off;

end-proc;

//-----------------------------------------------------------------
// return true of the sql statement just executed returned a warning.
//
// @since 1/2/18
//----------------------------------------------------------------
dcl-proc isSQLWarning export;

    dcl-pi isSQLWarning ind;
       sqlState varchar( 5 ) value;
    end-pi;

    if ( %subst( sqlState : 1 : 2 )  = '01' );
        return *on;
    endIf;

    return *off;

end-proc;

