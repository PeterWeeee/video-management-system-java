<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Video - ${video.title}</title>
    <style>
        .video-detail-box {
            border: 2px solid #333;
            background: #fff;
            max-width: 850px;
            margin: 0 auto;
        }
        .top-row {
            display: flex;
            border-bottom: 2px solid #333;
        }
        .poster-col {
            width: 320px;
            min-width: 280px;
            border-right: 2px solid #333;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8f9fa;
            padding: 10px;
        }
        .poster-col img {
            width: 100%;
            height: auto;
            max-height: 250px;
            object-fit: cover;
            border: 1px solid #ccc;
        }
        .info-col {
            flex: 1;
            padding: 20px;
        }
        .info-col p {
            margin-bottom: 8px;
            font-size: 16px;
        }
        .description-row {
            padding: 20px;
            background-color: #fafafa;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container my-4">
        <div class="d-flex justify-content-between align-items-center mb-3 mx-auto" style="max-width: 850px;">
            <h4 class="fw-bold text-primary mb-0">
                <i class="fa-solid fa-circle-play"></i> Chi Tiết Video
            </h4>
            <a href="${pageContext.request.contextPath}/videos/category?id=${video.categoryId}" class="btn btn-outline-secondary btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Quay lại Danh Mục
            </a>
        </div>

        <!-- Khung hiển thị chi tiết theo đúng mẫu Đề thi -->
        <div class="video-detail-box shadow-sm">
            <div class="top-row">
                <!-- [poster] -->
                <div class="poster-col">
                    <img src="${video.poster}" alt="[poster] ${video.title}">
                </div>

                <!-- Thông tin video -->
                <div class="info-col">
                    <p><strong>Tiêu đề:</strong> ${video.title}</p>
                    <p><strong>Mã video:</strong> ${video.videoId}</p>
                    <p><strong>Category name:</strong> <span class="badge bg-info text-dark">${video.categoryName}</span></p>
                    <p><strong>View:</strong> ${video.views}</p>
                    <p>
                        <span class="btn btn-outline-success btn-sm disabled me-2">
                            <i class="fa-solid fa-share-nodes"></i> Share(${video.shareCount})
                        </span>
                        <span class="btn btn-outline-primary btn-sm disabled">
                            <i class="fa-solid fa-thumbs-up"></i> Like(${video.likeCount})
                        </span>
                    </p>
                </div>
            </div>

            <!-- description -->
            <div class="description-row">
                <h6 class="fw-bold text-muted mb-2">Mô tả:</h6>
                <p class="mb-0 text-secondary" style="line-height: 1.6;">
                    ${video.description != null ? video.description : 'Không có mô tả cho video này.'}
                </p>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
