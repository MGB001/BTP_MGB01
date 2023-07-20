CLASS zmgbcl_insert_data_travel DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmgbcl_insert_data_travel IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lt_travel   TYPE TABLE OF zmgbt_travel,
          lt_booking  TYPE TABLE OF zmgbt_booking,
          lt_book_sup TYPE TABLE OF zmgbt_booksuppl.


    SELECT  travel_id, agency_id, customer_id, begin_date, end_date,
            booking_fee, total_price, currency_code, description,
            status AS overall_status, createdby AS created_by,
            createdat AS created_at, lastchangedby AS last_changed_by,
            lastchangedat AS last_changed_at
    FROM /dmo/travel INTO CORRESPONDING FIELDS OF
    TABLE @lt_travel
    UP TO 50 ROWS.

    SELECT *
    FROM /dmo/booking
    FOR ALL ENTRIES IN @lt_travel
    WHERE travel_id EQ @lt_travel-travel_id
    INTO CORRESPONDING FIELDS OF TABLE @lt_booking.

    SELECT *
    FROM /dmo/book_suppl
    FOR ALL ENTRIES IN @lt_booking
    WHERE travel_id EQ @lt_booking-travel_id
    AND booking_id EQ @lt_booking-booking_id
    INTO CORRESPONDING FIELDS OF TABLE @lt_book_sup.

    DELETE FROM: zmgbt_travel, zmgbt_booking, zmgbt_booksuppl.

    INSERT: zmgbt_travel FROM TABLE @lt_travel,
            zmgbt_booking FROM TABLE @lt_booking,
            zmgbt_booksuppl FROM TABLE @lt_book_sup.

    out->write( 'Se han insertado los datos de prueba.' ).

  ENDMETHOD.

ENDCLASS.
