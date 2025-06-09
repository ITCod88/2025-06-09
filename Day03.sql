-- DAY 3 --

-- 숫자 데이터 함수

-- ABS() : 절대값 표현
SELECT ABS(10), ABS(-10)
FROM DUAL;

-- MOD() : 주어진 컬럼이나 값을 나눈 나머지를 반환
SELECT MOD(10, 3), MOD(10, 6), (10/6)
FROM DUAL;

-- CEIL() : 소수점 첫째 자리에서 올림
-- FLOOR() : 소수점 이하 숫자를 버림
SELECT CEIL(123.456), CEIL(123.678), CEIL(123),
       FLOOR(123.456), FLOOR(123.678), FLOOR(123)
FROM DUAL;

-- TRUNC() : 지정한 위치에서부터 버림, 기본값은 0이다. **자주 쓰이는 함수
SELECT TRUNC(123.456, 0),
       TRUNC(123.456, 1),
       TRUNC(123.456, 2),
       TRUNC(123.456, -2)
FROM DUAL;


-- EMPLOYEE 테이블에서
-- 입사한 달이 홀수 달인 사원들의
-- 사번, 사원명, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE MOD(SUBSTR(HIRE_DATE, 5, 1), 2) = 1;

-- Oracle은 어느정도 형변환을 해준다. 그래서 위와 같이 문자인데도 숫자취급하여 나눌 수가 있다.


-- MONTHS_BETWEEN() : 두 날짜 사이의 개월 수
SELECT EMP_NAME, HIRE_DATE,
       TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
FROM EMPLOYEE;


-- NEXT_DAY()
-- 앞으로 다가올 가장 가까운 요일을 반환
-- 1:일요일 ~ 7:토요일
SELECT NEXT_DAY(SYSDATE, '토요일'),
	   NEXT_DAY(SYSDATE, '일'),
	   NEXT_DAY(SYSDATE, 6)
	   -- NEXT_DAY(SYSDATE, 'SATURDAY') 영어는 불가능
	   -- 언어설정이 한국어로 되어있기 때문이다.
FROM DUAL;

-- 현재 설정된 정보를 테이블 형태로 보관 -> 이러한 테이블을 '데이터 사전(데이터딕셔너리)'
SELECT * FROM V$NLS_PARAMETERS;

-- LAST_DAY() : 마지막 일(DAY)을 조회
SELECT LAST_DAY(SYSDATE)
FROM DUAL;

-- 날짜값 끼리 +,- 연산 가능
SELECT (SYSDATE - 10),
	   (SYSDATE - TO_DATE('2022/03/01', 'RR/MM/DD')),
	   (SYSDATE + 30)
FROM DUAL;

SELECT HIRE_DATE, (HIRE_DATE + 10)
FROM EMPLOYEE;


--
SELECT SYSDATE,
	   TO_CHAR(SYSDATE, 'RR/MM/DD'),
	   TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS'),
	   TO_CHAR(SYSDATE, 'YEAR, Q')|| '분기',
	   TO_CHAR(SYSDATE, 'MON, YYYY')
FROM DUAL;

-- 연도
-- Y/R
SELECT TO_CHAR(TO_DATE('190325', 'YYMMDD'), 'YYYY') "결과1",
	   TO_CHAR(TO_DATE('190325', 'RRMMDD'), 'RRRR') "결과2",
	   TO_CHAR(TO_DATE('800325', 'YYMMDD'), 'YYYY') "결과3",
	   TO_CHAR(TO_DATE('800325', 'RRMMDD'), 'RRRR') "결과4"
FROM DUAL;

-- 4자리 한번에 입력 받는 경우는 문제X
-- 2자리 입력 받을 경우
-- YY => 현 세기 기준으로 값을 추가
-- RR => 반 세기 


-- RR 
-- 50~99 -> 1900년대
-- 00~49 -> 2000년대

-- YY
-- 80 -> 2080


-- SELECT 문의 실행 순서
/*
-- 5: SELECT 컬럼 AS 별칭, 계산식, 함수
-- 1: FROM 테이블명
-- 2: WHERE 조건
-- 3: GROUP BY 그룹을 묶을 컬럼명
-- 4: HAVING 그룹에 대한 조건식, 함수식
-- 6: ORDER BY 컬럼|별칭|순서 [ASC/DESC][, 컬럼명...]
*/


-- ORDER BY --
SELECT EMP_ID, EMP_NAME 이름, SALARY, DEPT_CODE
FROM EMPLOYEE
-- ORDER BY EMP_ID ;  	-> 컬럼
-- ORDER BY 이름 DESC; 	-> 별칭
-- ORDER BY 3 DESC;   	-> 순서
ORDER BY 4 DESC, EMP_NAME;
-- 정렬을 한 상태에서 한 번더 정렬을 할 수 있다.


-- GROUP BY --

-- 부서별 평균 급여

-- 전체 사원의 급여 평균
SELECT TRUNC(AVG(SALARY), -3)
FROM EMPLOYEE;

-- D1의 평균
SELECT TRUNC(AVG(SALARY), -3)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- D6의 평균
SELECT TRUNC(AVG(SALARY), -3)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6';


-- GROUP BY 절 --
-- 특정 컬럼, 계산식을 기준으로
-- 그룹별로 묶어 한테이블 내에서 소그룹별로 조회하고자 할때 선언하는 구문


SELECT DEPT_CODE, TRUNC(AVG(SALARY), -3)
FROM EMPLOYEE
GROUP BY  DEPT_CODE;
-- 원래는 결과값의 ROW 개수가 맞지 않아 전체 평균과 DEPT_CODE를 같이 쓸수 없지만
-- 그룹으로 적절이 묶어 사용하여 해결


-- 부서 별 총인원, 급여 합계, 급여 평균, 최대 급여, 최소 급여를 조회
-- 단, 부서코드 기준으로 오름차순
-- 급여평균은 100의 자리까지만 처리하고 나머지는 버림처리하여 확인
SELECT DEPT_CODE, 
       COUNT(*), 
       SUM(SALARY), 
       TRUNC(AVG(SALARY), -3), 
       MAX(SALARY), 
       MIN(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;


















