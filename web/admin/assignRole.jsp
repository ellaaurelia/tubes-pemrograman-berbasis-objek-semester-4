<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Assign Role</title>
    <!--TailwindCSS CDN-->
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-100 text-gray-800">
    <div class="max-w-4xl mx-auto p-6 space-y-6">
        <h2 class="text-3xl font-bold text-indigo-600">Create Admin Role for Student</h2>

        <c:if test="${not empty message}">
            <p class="bg-green-100 text-green-700 px-4 py-2 rounded border border-green-300">
                ${message}
            </p>
        </c:if>

        <c:if test="${not empty error}">
            <p class="bg-red-100 text-red-700 px-4 py-2 rounded border border-red-300">
                ${error}
            </p>
        </c:if>

        <c:if test="${empty message and empty error}">
            <div class="overflow-x-auto bg-white shadow rounded">
                <table class="min-w-full">
                    <thead class="bg-indigo-500 text-white">
                        <tr>
                            <th class="px-4 py-2 text-left">Name</th>
                            <th class="px-4 py-2 text-left">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr class="border-b hover:bg-gray-50">
                                <td class="px-4 py-2">${user.name}</td>
                                <td class="px-4 py-2">
                                    <form action="${pageContext.request.contextPath}/assignRole" method="post" class="inline">
                                        <input type="hidden" name="user_id" value="${user.id}" />
                                        <button type="submit"
                                                class="bg-indigo-500 text-white px-3 py-1 rounded hover:bg-indigo-600">
                                            Create Admin account
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <c:if test="${empty users}">
                <p class="mt-2 text-gray-500 italic">No students available.</p>
            </c:if>
        </c:if>

        <a href="${pageContext.request.contextPath}/admin"
           class="inline-block bg-gray-300 hover:bg-gray-400 text-black px-4 py-2 rounded">
            ← Back to Admin Panel
        </a>
    </div>
</body>
</html>
