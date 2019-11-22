-- 카테고리제목, 내용?
SELECT category.title, category.content
FROM board
JOIN category ON board.category_id = category.category_id
WHERE board.author_id = 'bjy'
AND board_id = 1;

-- 좋아요 수
SELECT COUNT(*) FROM `like` WHERE board_id = 1;

-- 공유 수
SELECT COUNT(sharing_id) FROM sharing WHERE board_id = 1;

-- 게시글 내용
SELECT board.title '제목', IFNULL(board.sub_title,'') '소제목', author.name '작가명', board.register_date '작성일', IFNULL(attachment.root,'') '대표이미지', board.content
FROM board 
JOIN author ON board.author_id = author.author_id 
LEFT JOIN attachment ON attachment.attachment_id = board.attachment_id
WHERE category_id = (SELECT category.category_id FROM board JOIN category ON board.category_id = category.category_id WHERE board_id = 1)
AND board.board_id = 1;

-- 게시글에 포함된 태그
SELECT hashtag_name 
FROM board 
JOIN board_hashtag ON board.board_id = board_hashtag.board_id
WHERE board.board_id = 1;

-- 댓글
SELECT member.name '작성자', reply.register_date '작성일', reply.content '댓글내용' 
FROM reply
JOIN member ON reply.member_id = member.member_id
WHERE board_id = 1;

-- 작가이름, 작가직업, 작가소개글, 작가프로필 사진
SELECT author.name '작가명', job.name '작가직업', author.introduce '소개글', profile.root '프로필사진', (SELECT COUNT(*) FROM subscribe WHERE author_id = 'bjy') '구독자수'
FROM author 
JOIN member ON author_id = member_id 
JOIN profile ON profile.profile_id = member.profile_id 
JOIN job ON job.job_id = author.job_id
WHERE author.author_id = 'bjy';

-- 다른작가의 최신글 6개
SELECT IFNULL(attachment.root,'이미지없음') '게시글 대표이미지', board.title '제목', board.content '내용', board.author_id '작가명'
FROM board
LEFT JOIN attachment ON attachment.attachment_id = board.attachment_id
WHERE board.author_id != 'bjy' 
ORDER BY board_id DESC LIMIT 6;

-- 이전글, 다음글
SELECT board.title '제목' 
FROM board 
WHERE category_id = (SELECT category.category_id FROM board JOIN category ON board.category_id = category.category_id WHERE board_id = 1)
AND board.author_id = 'bjy'
AND board_id = 2;

