import Link from "next/link"

const getCertificaters = async() => {
    const response = await fetch(`http://localhost:3000/certificaters`, {
    method: "GET",
    headers : {
      "Accept": "application/json",
      "Content-Type" : "application/json"
    }
  })
  const json = await response.json()
  return json
}

const Certificaters = async() => {
    const certificaterList = await getCertificaters()
    return(
        <div>
            <h1>資格認定機関</h1>
            <div>
                <Link href={`http://localhost:4000/certificaters/new/`}>新規作成</Link>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>資格認定機関ID</th>
                        <th>資格認定機関名</th>
                        <th>資格認定機関名（英語）</th>
                        <th>編集</th>
                    </tr>
                </thead>
                <tbody>
                    {certificaterList.map(c =>
                        <tr key={c.id}>
                            <td>{c.id}</td>
                            <td>{c.name_ja}</td>
                            <td>{c.name_en}</td>
                            <td><Link href={`http://localhost:4000/certificaters/${c.id}`}>編集</Link></td>
                        </tr>
                    )}
                </tbody>
            </table>
            <div>
                <Link href={`http://localhost:4000/certificaters/new/`}>新規作成</Link>
            </div>
        </div>
    )
}
export default Certificaters