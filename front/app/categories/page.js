import Link from "next/link"

const getCategories = async() => {
  const response = await fetch(`${process.env.API_BASE_URL}/categories`, {
    method: "GET",
    headers : {
      "Accept": "application/json",
      "Content-Type" : "application/json"
    }
  })
  const json = await response.json()
  return json
}
const Categories = async() => {
    const categories = await getCategories()
    return(
        <div>
            <h1>カテゴリー</h1>
            <div>
                <Link href={`/categories/new/`}>新規登録</Link>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>カテゴリーID</th>
                        <th>カテゴリー名</th>
                        <th>カテゴリー名（英語）</th>
                        <th>資格数</th>
                        <th>編集</th>
                    </tr>
                </thead>
                <tbody>
                    {categories.map(c =>
                        <tr key={c.id}>
                            <td>{c.id}</td>
                            <td>{c.name_ja}</td>
                            <td>{c.name_en}</td>
                            <td>{c.qualifications_count}</td>
                            <td><Link href={`/categories/${c.id}`}>編集</Link></td>
                        </tr>
                    )}
                </tbody>
            </table>
            <div>
                <Link href={`/categories/new/`}>新規登録</Link>
            </div>
        </div>
    )
}

export default Categories