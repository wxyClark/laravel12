<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            SQL 执行器
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                    <!-- SQL 输入表单 -->
                    <form id="sqlForm">
                        @csrf

                        <div class="mb-6">
                            <label for="sql" class="block text-sm font-medium text-gray-700 mb-2">
                                SQL 语句
                            </label>
                            <textarea
                                id="sql"
                                name="sql"
                                rows="8"
                                class="w-full px-3 py-2 text-gray-700 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                                placeholder="请输入 SQL 查询语句，例如：SELECT * FROM users"
                                required
                            ></textarea>
                        </div>

                        <div class="flex items-center justify-between">
                            <div class="text-sm text-gray-600">
                                仅支持 SELECT 查询语句
                            </div>
                            <button
                                type="submit"
                                id="executeBtn"
                                class="px-6 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition duration-150 ease-in-out"
                            >
                                Execute
                            </button>
                        </div>
                    </form>

                    <!-- 加载状态 -->
                    <div id="loading" class="hidden mt-6 text-center">
                        <div class="inline-flex items-center">
                            <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-blue-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                            </svg>
                            <span class="text-gray-600">执行中...</span>
                        </div>
                    </div>

                    <!-- 错误提示 -->
                    <div id="errorAlert" class="hidden mt-6 bg-red-50 border border-red-200 rounded-lg p-4">
                        <div class="flex items-center">
                            <svg class="w-5 h-5 text-red-400 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
                            </svg>
                            <span id="errorMessage" class="text-red-800"></span>
                        </div>
                    </div>

                    <!-- 结果表格容器 -->
                    <div id="resultsContainer" class="hidden mt-8">
                        <div class="flex justify-between items-center mb-4">
                            <h3 class="text-lg font-medium text-gray-900">查询结果</h3>
                            <div class="text-sm text-gray-500">
                                <span id="resultCount">0</span> 条记录
                            </div>
                        </div>

                        <div class="overflow-x-auto border border-gray-200 rounded-lg">
                            <div class="overflow-auto max-h-96">
                                <table id="resultsTable" class="min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-50">
                                    <tr id="tableHeader">
                                        <!-- 表头将通过 JavaScript 动态生成 -->
                                    </tr>
                                    </thead>
                                    <tbody id="tableBody" class="bg-white divide-y divide-gray-200">
                                    <!-- 表格内容将通过 JavaScript 动态生成 -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    @push('scripts')
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const form = document.getElementById('sqlForm');
                const executeBtn = document.getElementById('executeBtn');
                const loading = document.getElementById('loading');
                const errorAlert = document.getElementById('errorAlert');
                const errorMessage = document.getElementById('errorMessage');
                const resultsContainer = document.getElementById('resultsContainer');
                const resultCount = document.getElementById('resultCount');
                const tableHeader = document.getElementById('tableHeader');
                const tableBody = document.getElementById('tableBody');

                form.addEventListener('submit', function(e) {
                    e.preventDefault();
                    executeQuery();
                });

                function executeQuery() {
                    const sql = document.getElementById('sql').value.trim();

                    if (!sql) {
                        showError('请输入 SQL 语句');
                        return;
                    }

                    // 显示加载状态
                    loading.classList.remove('hidden');
                    errorAlert.classList.add('hidden');
                    resultsContainer.classList.add('hidden');
                    executeBtn.disabled = true;

                    // AJAX 请求
                    fetch('/dev/commonList', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-TOKEN': document.querySelector('input[name="_token"]').value,
                            'Accept': 'application/json'
                        },
                        body: JSON.stringify({ sql: sql })
                    })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('网络响应不正常');
                            }
                            return response.json();
                        })
                        .then(data => {
                            displayResults(data);
                        })
                        .catch(error => {
                            showError('执行失败: ' + error.message);
                        })
                        .finally(() => {
                            loading.classList.add('hidden');
                            executeBtn.disabled = false;
                        });
                }

                function displayResults(data) {
                    if (!data || !Array.isArray(data) || data.length === 0) {
                        showError('没有查询到数据');
                        return;
                    }

                    // 更新结果计数
                    resultCount.textContent = data.length;

                    // 获取所有字段名
                    const columns = Object.keys(data[0]);

                    // 生成表头
                    tableHeader.innerHTML = '';
                    columns.forEach((column, index) => {
                        const th = document.createElement('th');
                        th.className = `px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider ${
                            index < 3 ? 'sticky left-0 bg-gray-50 z-10' : ''
                        }`;
                        th.textContent = column;
                        tableHeader.appendChild(th);
                    });

                    // 生成表格内容
                    tableBody.innerHTML = '';
                    data.forEach((row, rowIndex) => {
                        const tr = document.createElement('tr');
                        tr.className = rowIndex % 2 === 0 ? 'bg-white' : 'bg-gray-50';

                        columns.forEach((column, colIndex) => {
                            const td = document.createElement('td');
                            const value = row[column] !== null && row[column] !== undefined ?
                                String(row[column]) : '';

                            // 设置单元格样式
                            const cellClasses = [
                                'px-4',
                                'py-3',
                                'text-sm',
                                'text-gray-900',
                                colIndex < 3 ? 'sticky left-0 z-10' : ''
                            ];

                            if (colIndex < 3) {
                                cellClasses.push(rowIndex % 2 === 0 ? 'bg-white' : 'bg-gray-50');
                            }

                            // 根据内容长度设置样式
                            if (value.length <= 30) {
                                cellClasses.push('whitespace-nowrap truncate');
                            } else {
                                cellClasses.push('break-words max-w-xs');
                            }

                            td.className = cellClasses.join(' ');
                            td.textContent = value;
                            td.title = value; // 添加 title 提示完整内容

                            tr.appendChild(td);
                        });

                        tableBody.appendChild(tr);
                    });

                    // 显示结果容器
                    resultsContainer.classList.remove('hidden');
                }

                function showError(message) {
                    errorMessage.textContent = message;
                    errorAlert.classList.remove('hidden');
                    resultsContainer.classList.add('hidden');
                }
            });
        </script>
    @endpush

    <style>
        /* 自定义滚动条样式 */
        .overflow-auto::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }

        .overflow-auto::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 4px;
        }

        .overflow-auto::-webkit-scrollbar-thumb {
            background: #c1c1c1;
            border-radius: 4px;
        }

        .overflow-auto::-webkit-scrollbar-thumb:hover {
            background: #a8a8a8;
        }

        /* 固定列样式 */
        .sticky {
            position: sticky;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }

        /* 确保固定列在滚动时显示在上层 */
        .sticky.z-10 {
            z-index: 10;
        }

        /* 表格单元格最大宽度 */
        .max-w-xs {
            max-width: 12rem;
        }
    </style>
</x-app-layout>
