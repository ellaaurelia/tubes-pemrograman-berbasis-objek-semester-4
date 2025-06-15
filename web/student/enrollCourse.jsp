<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Enroll Course</title>
    <!-- TailwindCSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">
    <div class="max-w-4xl mx-auto p-6">
        <h2 class="text-2xl font-bold text-indigo-500 mb-4">Enroll Course</h2>

        <div class="overflow-x-auto">
            <table class="min-w-full bg-white shadow-md rounded mb-6">
                <thead>
                    <tr class="bg-indigo-500 text-white">
                        <th class="px-4 py-2 text-left">Name</th>
                        <th class="px-4 py-2 text-left">Description</th>
                        <th class="px-4 py-2 text-left">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="course" items="${courses}">
                        <tr class="border-b hover:bg-gray-50">
                            <td class="px-4 py-2">${course.name}</td>
                            <td class="px-4 py-2">${course.description}</td>
                            <td class="px-4 py-2">
                                <form method="post" action="${pageContext.request.contextPath}/enroll">
                                    <input type="hidden" name="courseId" value="${course.id}" />
                                    <button type="submit" class="bg-indigo-500 text-white px-4 py-1 rounded hover:bg-indigo-600">
                                        Enroll
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${empty courses}">
            <p class="text-gray-500 italic mb-6">No courses available.</p>
        </c:if>

        <a href="${pageContext.request.contextPath}/student"
           class="inline-block bg-gray-300 hover:bg-gray-400 text-gray-800 px-4 py-2 rounded">
            Back to Dashboard
        </a>
    </div>
</body>
</html>
