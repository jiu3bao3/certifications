import Link from "next/link"

const getExaminers = async() => {
    const response = await fetch(`${process.env.API_BASE_URL}/examiners`, {
    method: "GET",
    headers : {
      "Accept": "application/json",
      "Content-Type" : "application/json"
    }
  })
  const json = await response.json()
  return json
}

const Examiners = async() => {
    const examinerList = await getExaminers()
    return (
        <div>
            <h1>試験実施機関</h1>
            <div>
                <Link href={`/examiners/new/`}>新規作成</Link>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>試験実施機関ID</th>
                        <th>試験実施機関名</th>
                        <th>所在地</th>
                        <th>編集</th>
                    </tr>
                </thead>
                <tbody>
                    {examinerList.map(e =>
                        <tr key={e.id}>
                            <td>{e.id}</td>
                            <td>{e.name}</td>
                            <td>{e.address}</td>
                            <td><Link href={`/examiners/${e.id}`}>編集</Link></td>
                        </tr>
                    )}
                </tbody>
            </table>
            <div>
                <Link href={`/examiners/new/`}>新規作成</Link>
            </div>
        </div>
    )
}
export default Examiners
