/* ORDER */
SELECT
       MENU_CODE
	 , MENU_NAME
	 , MANTU_PTICE
  FROM TBL_MANU
-- order by MENU_PRICE ASC; 생략가능
ORDER BY MENU_PRICE;

SELECT
       MENU_CODE
	 , MENU_NAME
	 , MANTU_PTICE
  FROM TBL_MANU
ORDER BY MENU_PRICE DESC;

SELECT
       MENU_CODE
	 , MENU_NAME
	 , MANTU_PTICE
  FROM TBL_MANU
  ORDER BY MENU_PRICR DESC,
           MENU_NAME ASC;
           
SELECT
       MENU_CODE
	, MANTU_PTICE
    , MENU_CODE * MANTU_PTICE
FROM TBL_MANU
ORDER BY MENU_CODE * MANTU_PTICE DESC;

SELECT FIELD('A', 'A', 'B', 'C'); -- A와 같은 것을 찾고 결과 : 1
SELECT FIELD('B', 'A', 'B', 'C'); -- B와 같은 것을 찾음 결과 : 2

SELECT
       FIELD(ORDERABLE_STATUS,'N', 'Y')
  FROM TBL_MENU;
  
-- 오름차순 시 NULL 처음으로
SELECT
       CATEGORY_CODE
       , CATEGORY_NAME
       ,REF_CATEGORY_CODE
  FROM TBL_CATEGORY
ORDER BY REF_CATEGORY_CODE;

-- 오름차순 시 NULL 마지막으로
SELECT
       CATEGORY_CODE
       , CATEGORY_NAME
       ,REF_CATEGORY_CODE
  FROM TBL_CATEGORY
ORDER BY REF_CATEGORY_CODE IS NULL;

-- 내림차순 시 NULL 마지막으로
SELECT
       CATEGORY_CODE
       , CATEGORY_NAME
       ,REF_CATEGORY_CODE
  FROM TBL_CATEGORY
ORDER BY REF_CATEGORY_CODE DESC;

-- 내림차순 시 NULL 처음으로
SELECT
       CATEGORY_CODE
       , CATEGORY_NAME
       ,REF_CATEGORY_CODE
  FROM TBL_CATEGORY
ORDER BY REF_CATEGORY_CODE IS NULL DESC, REF_CATEGORY_CODE DESC;